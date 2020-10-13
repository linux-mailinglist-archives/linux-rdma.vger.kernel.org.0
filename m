Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E727228D72D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 01:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgJMXuW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 19:50:22 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:38707 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgJMXtY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 19:49:24 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 09DNmu3a014730;
        Tue, 13 Oct 2020 16:48:57 -0700
Date:   Wed, 14 Oct 2020 05:18:56 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        dledford@redhat.com, oren@nvidia.com, maxg@mellanox.com
Subject: Re: [PATCH 1/1] IB/isert: add module param to set sg_tablesize for
 IO cmd
Message-ID: <20201013234726.GA8423@chelsio.com>
References: <20201011090608.159333-1-mgurtovoy@nvidia.com>
 <1d4f4c66-5c87-c2c2-c45b-6ab6a30481ea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4f4c66-5c87-c2c2-c45b-6ab6a30481ea@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, October 10/13/20, 2020 at 20:43:03 +0300, Max Gurtovoy wrote:
> Krishna,
> 
> did this patch fix the issue you reported ?

With this patch applied, I don't see the reported issue anymore.
Thanks for the patch!



> 
> 
> On 10/11/2020 12:06 PM, Max Gurtovoy wrote:
> >From: Max Gurtovoy <maxg@mellanox.com>
> >
> >Currently, iser target support max IO size of 16MiB by default. For some
> >adapters, allocating this amount of resources might reduce the total
> >number of possible connections that can be created. For those adapters,
> >it's preferred to reduce the max IO size to be able to create more
> >connections. Since there is no handshake procedure for max IO size in
> >iser protocol, set the default max IO size to 1MiB and add a module
> >parameter for enabling the option to control it for suitable adapters.
> >
> >Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> >Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> >---
> >  drivers/infiniband/ulp/isert/ib_isert.c | 27 ++++++++++++++++++++++++-
> >  drivers/infiniband/ulp/isert/ib_isert.h |  6 ++++++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> >index 695f701dc43d..5a47f1bbca96 100644
> >--- a/drivers/infiniband/ulp/isert/ib_isert.c
> >+++ b/drivers/infiniband/ulp/isert/ib_isert.c
> >@@ -28,6 +28,18 @@ static int isert_debug_level;
> >  module_param_named(debug_level, isert_debug_level, int, 0644);
> >  MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0 (default:0)");
> >+static int isert_sg_tablesize_set(const char *val,
> >+				  const struct kernel_param *kp);
> >+static const struct kernel_param_ops sg_tablesize_ops = {
> >+	.set = isert_sg_tablesize_set,
> >+	.get = param_get_int,
> >+};
> >+
> >+static int isert_sg_tablesize = ISCSI_ISER_SG_TABLESIZE;
> >+module_param_cb(sg_tablesize, &sg_tablesize_ops, &isert_sg_tablesize, 0644);
> >+MODULE_PARM_DESC(sg_tablesize,
> >+		 "Number of gather/scatter entries in a single scsi command, should >= 128 (default: 256, max: 4096)");
> >+
> >  static DEFINE_MUTEX(device_list_mutex);
> >  static LIST_HEAD(device_list);
> >  static struct workqueue_struct *isert_comp_wq;
> >@@ -47,6 +59,19 @@ static void isert_send_done(struct ib_cq *cq, struct ib_wc *wc);
> >  static void isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc);
> >  static void isert_login_send_done(struct ib_cq *cq, struct ib_wc *wc);
> >+static int isert_sg_tablesize_set(const char *val, const struct kernel_param *kp)
> >+{
> >+	int n = 0, ret;
> >+
> >+	ret = kstrtoint(val, 10, &n);
> >+	if (ret != 0 || n < ISCSI_ISER_MIN_SG_TABLESIZE ||
> >+	    n > ISCSI_ISER_MAX_SG_TABLESIZE)
> >+		return -EINVAL;
> >+
> >+	return param_set_int(val, kp);
> >+}
> >+
> >+
> >  static inline bool
> >  isert_prot_cmd(struct isert_conn *conn, struct se_cmd *cmd)
> >  {
> >@@ -101,7 +126,7 @@ isert_create_qp(struct isert_conn *isert_conn,
> >  	attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
> >  	attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
> >  	factor = rdma_rw_mr_factor(device->ib_device, cma_id->port_num,
> >-				   ISCSI_ISER_MAX_SG_TABLESIZE);
> >+				   isert_sg_tablesize);
> >  	attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX * factor;
> >  	attr.cap.max_send_sge = device->ib_device->attrs.max_send_sge;
> >  	attr.cap.max_recv_sge = 1;
> >diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
> >index 7fee4a65e181..90ef215bf755 100644
> >--- a/drivers/infiniband/ulp/isert/ib_isert.h
> >+++ b/drivers/infiniband/ulp/isert/ib_isert.h
> >@@ -65,6 +65,12 @@
> >   */
> >  #define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)
> >+/* Default I/O size is 1MB */
> >+#define ISCSI_ISER_SG_TABLESIZE 256
> >+
> >+/* Minimum I/O size is 512KB */
> >+#define ISCSI_ISER_MIN_SG_TABLESIZE 128
> >+
> >  /* Maximum support is 16MB I/O size */
> >  #define ISCSI_ISER_MAX_SG_TABLESIZE	4096
