Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92400344942
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCVPbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 11:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhCVPbM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 11:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 518196198D;
        Mon, 22 Mar 2021 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616427072;
        bh=QTeCwb79KDXmtdPk8PR3/zJRadw5L3iAmL7vbC+YvBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=suWjKqKFxJWLKY/0OqlJVAvmG0Nb8Kg/ZVKrYgj1DKiKgtXx696y51TR0YdIpekVV
         pQvsxgYicIyuNe6uZo4SRiTe6MyB45w7X/vM8iL6tiKGZJT2UV3S3+3r49+umR9Xyy
         b2V9w9uSseYBaZtlO2NztzKOAVBM9WnrOtEPD+NkwWt0zgMD0fqi+gMcdNlqK7h4tO
         +771/M2yRlxyTzWMj7FT7f3iH+GNtv036EboTj05waOJmjreLwClKaLvXdMjPjFr5p
         7HVVtjc5yf470mHaPOZYH4UXtnmiy+Fv2VGtB79XajJ/zPu3bGf7eTe6+ySa/PU2m+
         V0361Vp8kaDpA==
Date:   Mon, 22 Mar 2021 17:31:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     lyl2019@mail.ustc.edu.cn
Cc:     sagi@grimberg.me, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] infiniband: Fix a use after free in
 isert_connect_request
Message-ID: <YFi4PKJLjMkIXmas@unreal>
References: <20210322135355.5720-1-lyl2019@mail.ustc.edu.cn>
 <YFipRTHpr8Xqho4V@unreal>
 <1af3e912.b6e4.1785a6b7802.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1af3e912.b6e4.1785a6b7802.Coremail.lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 10:51:35PM +0800, lyl2019@mail.ustc.edu.cn wrote:
> 
> 
> 
> > -----原始邮件-----
> > 发件人: "Leon Romanovsky" <leon@kernel.org>
> > 发送时间: 2021-03-22 22:27:17 (星期一)
> > 收件人: "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
> > 抄送: sagi@grimberg.me, dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
> > 主题: Re: [PATCH] infiniband: Fix a use after free in isert_connect_request
> > 
> > On Mon, Mar 22, 2021 at 06:53:55AM -0700, Lv Yunlong wrote:
> > > The device is got by isert_device_get() with refcount is 1,
> > > and is assigned to isert_conn by isert_conn->device = device.
> > > When isert_create_qp() failed, device will be freed with
> > > isert_device_put().
> > > 
> > > Later, the device is used in isert_free_login_buf(isert_conn)
> > > by the isert_conn->device->ib_device statement. My patch
> > > exchanges the callees order to free the device late.
> > > 
> > > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > > ---
> > >  drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > The fix needs to be change of isert_free_login_buf() from
> > isert_free_login_buf(isert_conn) to be isert_free_login_buf(isert_conn, cma_id->device)
> > 
> > Thanks
> > 
> > > 
> > > diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> > > index 7305ed8976c2..d8a533e346b0 100644
> > > --- a/drivers/infiniband/ulp/isert/ib_isert.c
> > > +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> > > @@ -473,10 +473,10 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
> > >  
> > >  out_destroy_qp:
> > >  	isert_destroy_qp(isert_conn);
> > > -out_conn_dev:
> > > -	isert_device_put(device);
> > >  out_rsp_dma_map:
> > >  	isert_free_login_buf(isert_conn);
> > > +out_conn_dev:
> > > +	isert_device_put(device);
> > >  out:
> > >  	kfree(isert_conn);
> > >  	rdma_reject(cma_id, NULL, 0, IB_CM_REJ_CONSUMER_DEFINED);
> > > -- 
> > > 2.25.1
> > > 
> > > 
> 
> I see that function isert_free_login_buf(struct isert_conn *isert_conn) has only
> a parameter,  do you mean i need change the implementation of isert_free_login_buf?
> 
> I'm sorry to say that i am unfamilar with this module and afraid of making more mistakes,
> because this function is being called elsewhere as well.
> Could you help me to fix this issue? Or just fix it and tell me your commit number?

After checking how isert_connect_release() is implemented, it looks like
this will fix:

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 7305ed8976c2..18266f07c58d 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -438,23 +438,23 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 	isert_init_conn(isert_conn);
 	isert_conn->cm_id = cma_id;
 
-	ret = isert_alloc_login_buf(isert_conn, cma_id->device);
-	if (ret)
-		goto out;
-
 	device = isert_device_get(cma_id);
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
-		goto out_rsp_dma_map;
+		goto out;
 	}
 	isert_conn->device = device;
 
+	ret = isert_alloc_login_buf(isert_conn, cma_id->device);
+	if (ret)
+		goto out_conn_dev;
+
 	isert_set_nego_params(isert_conn, &event->param.conn);
 
 	isert_conn->qp = isert_create_qp(isert_conn, cma_id);
 	if (IS_ERR(isert_conn->qp)) {
 		ret = PTR_ERR(isert_conn->qp);
-		goto out_conn_dev;
+		goto out_rsp_dma_map;
 	}
 
 	ret = isert_login_post_recv(isert_conn);
@@ -473,10 +473,10 @@ isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 
 out_destroy_qp:
 	isert_destroy_qp(isert_conn);
-out_conn_dev:
-	isert_device_put(device);
 out_rsp_dma_map:
 	isert_free_login_buf(isert_conn);
+out_conn_dev:
+	isert_device_put(device);
 out:
 	kfree(isert_conn);
 	rdma_reject(cma_id, NULL, 0, IB_CM_REJ_CONSUMER_DEFINED);
