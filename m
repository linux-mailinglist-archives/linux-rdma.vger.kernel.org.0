Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4991E3B65C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfFJNrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 09:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390310AbfFJNrE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 09:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD4A0C045129;
        Mon, 10 Jun 2019 13:47:03 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79B136149E;
        Mon, 10 Jun 2019 13:46:57 +0000 (UTC)
Date:   Mon, 10 Jun 2019 09:46:53 -0400
From:   Honggang LI <honli@redhat.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [rdma-core patch] ibacm: only open InfiniBand port
Message-ID: <20190610134653.GA20242@localhost.localdomain>
References: <20190522124528.5688-1-honli@redhat.com>
 <879912FA-8559-4814-9D07-DC438F682A00@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <879912FA-8559-4814-9D07-DC438F682A00@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 10 Jun 2019 13:47:03 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 04, 2019 at 04:07:55PM +0200, Håkon Bugge wrote:
> Hi Honggang,
> 
> 
> Thanks for your commit. Been OOO, so sorry for the delay.
> 
> > On 22 May 2019, at 14:45, Honggang Li <honli@redhat.com> wrote:
> > 
> > The low 64 bits of cxgb3 and cxgb4 devices' GID are zeros. If the
> > "provider" was set in the option file, ibacm will failed with
> 
> s/failed/fail/

ok

> 
> > segment fault.
> > 
> > $ sed -i -e 's/# provider ibacmp 0xFE80000000000000/provider ibacmp 0xFE80000000000000/g' /etc/rdma/ibacm_opts.cfg
> > $ /usr/sbin/ibacm --systemd
> > Segmentation fault (core dumped)
> 
> Please add a stack trace so others can easily identify this commit as a fix if they run into the same bug.

will add a stack trace.

> > acm_open_dev function should not open port for IWARP or ROCE devices.
> 
> s/open port/open a umad port/

s/open port/open an umad port/

> s/IWARP/iWARP/
> s/ROCE/RoCE/

ok

> 
> > 
> > Signed-off-by: Honggang Li <honli@redhat.com>
> > ---
> > ibacm/src/acm.c | 14 +++++++++++++-
> > 1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
> > index a21069d4..944cb820 100644
> > --- a/ibacm/src/acm.c
> > +++ b/ibacm/src/acm.c
> > @@ -2587,7 +2587,7 @@ acm_open_port(struct acmc_port *port, struct acmc_device *dev, uint8_t port_num)
> > 
> > 	port->mad_agentid = umad_register(port->mad_portid,
> > 					  IB_MGMT_CLASS_SA, 1, 1, NULL);
> > -	if (port->mad_agentid < 0) {
> > +	if (port->mad_agentid < 0 && port->mad_portid > 0) {
> 
> It is cleaner to handle the error from umad_open_port() in the if-test where it is checked for error, i.e., "if (port->mad_portid < 0)". Or in other words, why call umad_open_port() when there was an error from umad_open_port()?
> 
> But is this related to $Subject? To me, this seems to fix a double error message. If you agree, please separate this error fix reporting into a separate commit.

It is not related to $Subject. As it is safe to ignore this, so will
drop it.

> 
> > 		umad_close_port(port->mad_portid);
> > 		acm_log(0, "ERROR - unable to register MAD client\n");
> > 	}
> > @@ -2600,6 +2600,7 @@ static void acm_open_dev(struct ibv_device *ibdev)
> > {
> > 	struct acmc_device *dev;
> > 	struct ibv_device_attr attr;
> > +	struct ibv_port_attr port_attr;
> > 	struct ibv_context *verbs;
> > 	size_t size;
> > 	int i, ret;
> > @@ -2628,6 +2629,17 @@ static void acm_open_dev(struct ibv_device *ibdev)
> > 	list_head_init(&dev->prov_dev_context_list);
> > 
> > 	for (i = 0; i < dev->port_cnt; i++) {
> > +		acm_log(1, "%s %d\n", dev->device.verbs->device->name, i);
> 
> Shouldn't "ibdev->name" suffice instead of "dev->device.verbs->device->name" ?

ok

> 
> i + 1 (Port numbers starts at one)

yes, you are right. I increased the port number for ibv_query_port
function, but missed this one.

> 
> > +		ret = ibv_query_port(dev->device.verbs, i+1, &port_attr);
> 
> s/i+1/i + 1/ (we use kernel style)

ok

> 
> > +		if (ret) {
> > +			acm_log(0, "ERROR - unable to query an RDMA port's attributes\n");
> > +			return;
> 
> a return here is inappropriate. First, you miss to close the device (aka goto err1). In addition, the query of the first port could fail, but you will not query the next port(s), which may succeed (and be an IB link-layer device). So I think a "continue" is the best solution.
> 
> > +		}
> > +		if (port_attr.link_layer != IBV_LINK_LAYER_INFINIBAND) {
> > +			acm_log(1, "not an InfiniBand port\n");
> > +			return;
> 
> ditto, but suppress the list_add() below if no ports are opened.

I think I fixed these issues, please see v2 for details.

> 
> 
> 
> Thxs, Håkon
> 
> > +		}
> > +
> > 		acm_open_port(&dev->port[i], dev, i + 1);
> > 	}
> > 
> > -- 
> > 2.20.1
