Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE584ED5D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFUQrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 12:47:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35616 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUQrS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 12:47:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so7609087qto.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CUFnJegSwavYs+mjOk+iVMaZvUgv2zxtWRu9xJJpBuQ=;
        b=Od9Kmh9wz6g0HksE3CC+BoibDqBPeECou9pzALrJkTs/UPIWpAfhKvcnIaRnqaHnie
         nciAuZH9+ck4Z3cWEDT+nwC97xkcHrh/8VpTKbUuQqVdZDUHo4S7H/qnXy5iquInpGpq
         aoyhnbyjiE7PT82nG9k4Rt5BDyEAkt2pHpEeg+LQUG/W9T+FAjBUyOtmvU+M1eJtYMa0
         53T4MXQQMQ2nQg2UWkMCd5rCgz6hjFiVWvv3zW8yUHNdk07VCea/mIET8SQmWxBr+Kfw
         arbahqD1bDWFpDvZA53lNpZ2cpT32uuzPbcK3cKd4MFB81hblRYvc9TRH2HbDlMTc8tY
         zX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUFnJegSwavYs+mjOk+iVMaZvUgv2zxtWRu9xJJpBuQ=;
        b=WyUSsduwXRaXc1aSE7PX9DOLtFWTGGWG4ATSM1F1IB/LA6nDPwByFVwMs5vhcP4BII
         IioU56PluoQPYykZpTYiQmPaPzp6Z3l8dzOGM0IrXHedbv6XXTYBUnl1l1aY7vm96MiG
         3qxMS0/55YcWvhtWBPXf43Zxcm+tKRWHcUzfN19TA7G6a8ygQExhyEhRFfLRKeSmPCiG
         z3s7lLgG2ES27AUwTXajCks2p000pHbOK4NaanAj6QsaGsbbAFJTu0QLdMxlgZH1MREg
         vM2lsO+GvSD2iHuGM8jMQPkxaP+mIihPPkZUSsXVJv9f703ixGUxPFKWuty8n1Bqog+0
         3vVA==
X-Gm-Message-State: APjAAAURdTpOMSs4bNXTkY4HeUp0TrFHmIP/w5HVr9tJBeblSXHtNBED
        HAeVHSeapoO8wh37LWzjDvM/Zg==
X-Google-Smtp-Source: APXvYqwOmOzRao8K0C0VRkCHQxMVoFhbSkJje4VHWJwE68GdK5/RSSlIXS/b4zltlFEKf6OHFfKGzg==
X-Received: by 2002:aed:3a03:: with SMTP id n3mr82140199qte.85.1561135636666;
        Fri, 21 Jun 2019 09:47:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p31sm2122986qtk.55.2019.06.21.09.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 09:47:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heMh1-00051a-JQ; Fri, 21 Jun 2019 13:47:15 -0300
Date:   Fri, 21 Jun 2019 13:47:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        yuval.shaia@oracle.com
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH for-next v3 1/4] RDMA/uverbs: uobj_get_obj_read should
 return the ib_uobject
Message-ID: <20190621164715.GA26510@ziepe.ca>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
 <20190530122422.32283-2-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530122422.32283-2-shamir.rabinovitch@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 03:24:06PM +0300, Shamir Rabinovitch wrote:
> future patch will remove the ib_uobject pointer from the ib_x
> objects. the uobj_get_obj_read and uobj_put_obj_read macros
> were constructed with the ability to reach the ib_uobject from
> ib_x in mind. this need to change now.
> 
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>  drivers/infiniband/core/uverbs_cmd.c | 125 ++++++++++++++++++++-------
>  include/rdma/uverbs_std_types.h      |   8 +-
>  2 files changed, 98 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 5a3a1780ceea..f1320de2b388 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -37,6 +37,7 @@
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> +#include <linux/list.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -700,6 +701,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
>  	struct ib_uverbs_reg_mr      cmd;
>  	struct ib_uverbs_reg_mr_resp resp;
>  	struct ib_uobject           *uobj;
> +	struct ib_uobject           *pduobj;
>  	struct ib_pd                *pd;
>  	struct ib_mr                *mr;
>  	int                          ret;
> @@ -720,7 +722,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
>  	if (IS_ERR(uobj))
>  		return PTR_ERR(uobj);
>  
> -	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
> +	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
> +			       &pduobj);
>  	if (!pd) {
>  		ret = -EINVAL;
>  		goto err_free;

So rather than continuing to expose the uobject, I'd like to make the
write() path work more closely to the ioctl path, and have the core
manage the uobj. The write method should just be responsible to find
it.

Ultimately the uobj should not exist at all in very much code outside
rdma_core.c and uverbs_ioctl.c

Basically like this sketch below.

This will work with the ioctl write emulation path already, but the
actual write() path needs to be updated to provide a bundle_priv and
then destroy it when the method is done (like ioctl does), which is
another small patch and is something that has been needed anyhow.

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index ccf4d069c25c99..3e6d5c9791c94d 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -422,6 +422,26 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	return ERR_PTR(ret);
 }
 
+/* Automatic version, does the put when the method ends and returns the HW object */
+void *rdma_lookup_get_obj(const struct uverbs_api_object *obj, s64 id,
+			  enum rdma_lookup_mode mode,
+			  struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj;
+	int ret;
+
+	uobj = rdma_lookup_get_uobject(obj, attrs->ufile, id, mode, attrs);
+	if (IS_ERR(uobj))
+		return ERR_CAST(uobj);
+
+	ret = uverbs_auto_put(attrs, mode, uobj);
+	if (ret) {
+		rdma_lookup_put_uobject(uobj, mode);
+		return ERR_PTR(ret);
+	}
+	return uobj->object;
+}
+
 static struct ib_uobject *
 alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
 			struct ib_uverbs_file *ufile)
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 5445323629b5b5..0fa337f6358d1f 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -104,6 +104,8 @@ uverbs_get_uobject_from_file(u16 object_id, enum uverbs_obj_access access,
 int uverbs_finalize_object(struct ib_uobject *uobj,
 			   enum uverbs_obj_access access, bool commit,
 			   struct uverbs_attr_bundle *attrs);
+int uverbs_auto_put(struct uverbs_attr_bundle *bundle,
+		    enum uverbs_obj_access access, struct ib_uobject *uobj);
 
 int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5c00d9a5698ac7..eb10103628e41e 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -720,9 +720,9 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	pd = uobj_aget_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err_free;
 	}
 
@@ -731,7 +731,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 		      IB_DEVICE_ON_DEMAND_PAGING)) {
 			pr_debug("ODP support not available\n");
 			ret = -EINVAL;
-			goto err_put;
+			goto err_free;
 		}
 	}
 
@@ -740,7 +740,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 					 &attrs->driver_udata);
 	if (IS_ERR(mr)) {
 		ret = PTR_ERR(mr);
-		goto err_put;
+		goto err_free;
 	}
 
 	mr->device  = pd->device;
@@ -762,16 +762,11 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
-
 	return uobj_alloc_commit(uobj, attrs);
 
 err_copy:
 	ib_dereg_mr_user(mr, &attrs->driver_udata);
 
-err_put:
-	uobj_put_obj_read(pd);
-
 err_free:
 	uobj_alloc_abort(uobj, attrs);
 	return ret;
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 829b0c6944d842..3983df53eb9a61 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -40,6 +40,12 @@ struct bundle_alloc_head {
 	u8 data[];
 };
 
+struct bundle_uobj_put {
+	struct hlist_node next;
+	struct ib_uobject *uobj;
+	enum uverbs_obj_access access;
+};
+
 struct bundle_priv {
 	/* Must be first */
 	struct bundle_alloc_head alloc_head;
@@ -58,6 +64,7 @@ struct bundle_priv {
 
 	DECLARE_BITMAP(uobj_finalize, UVERBS_API_ATTR_BKEY_LEN);
 	DECLARE_BITMAP(spec_finalize, UVERBS_API_ATTR_BKEY_LEN);
+	struct hlist_head uobj_finalize_list;
 
 	/*
 	 * Must be last. bundle ends in a flex array which overlaps
@@ -495,10 +502,31 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	return ret;
 }
 
+/*
+ * This will automatically do the put for the given ib_uobject when the method
+ * ends.
+ */
+int uverbs_auto_put(struct uverbs_attr_bundle *bundle,
+		    enum uverbs_obj_access access, struct ib_uobject *uobj)
+{
+	struct bundle_priv *pbundle =
+		container_of(bundle, struct bundle_priv, bundle);
+	struct bundle_uobj_put *putter;
+
+	putter = uverbs_alloc(bundle, sizeof(putter));
+	if (!putter)
+		return -ENOMEM;
+	putter->uobj = uobj;
+	putter->access = access;
+	hlist_add_head(&putter->next, &pbundle->uobj_finalize_list);
+	return 0;
+}
+
 static int bundle_destroy(struct bundle_priv *pbundle, bool commit)
 {
 	unsigned int key_bitmap_len = pbundle->method_elm->key_bitmap_len;
 	struct bundle_alloc_head *memblock;
+	struct bundle_uobj_put *putter;
 	unsigned int i;
 	int ret = 0;
 
@@ -542,6 +570,15 @@ static int bundle_destroy(struct bundle_priv *pbundle, bool commit)
 		}
 	}
 
+	hlist_for_each_entry (putter, &pbundle->uobj_finalize_list, next) {
+		int current_ret;
+
+		current_ret = uverbs_finalize_object(
+			putter->uobj, putter->access, commit, &pbundle->bundle);
+		if (!ret)
+			ret = current_ret;
+	}
+
 	for (memblock = pbundle->allocated_mem; memblock;) {
 		struct bundle_alloc_head *tmp = memblock;
 
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index 05eabfd5d0d3e3..a867417eceb338 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -68,6 +68,11 @@ static inline void *_uobj_get_obj_read(struct ib_uobject *uobj)
 	((struct ib_##_object *)_uobj_get_obj_read(                            \
 		uobj_get_read(_type, _id, _attrs)))
 
+#define uobj_aget_read(_object, _type, _id, _attrs)                            \
+	((struct ib_##_object *)rdma_lookup_get_obj(                           \
+		uobj_get_type(_attrs, _type), _uobj_check_id(_id),             \
+		UVERBS_LOOKUP_READ, _attrs))
+
 #define uobj_get_write(_type, _id, _attrs)                                     \
 	rdma_lookup_get_uobject(uobj_get_type(_attrs, _type), (_attrs)->ufile, \
 				_uobj_check_id(_id), UVERBS_LOOKUP_WRITE,      \
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index d57a5ba00c743e..df7b51bc98dd91 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -135,6 +135,9 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 					   struct ib_uverbs_file *ufile, s64 id,
 					   enum rdma_lookup_mode mode,
 					   struct uverbs_attr_bundle *attrs);
+void *rdma_lookup_get_obj(const struct uverbs_api_object *obj, s64 id,
+			  enum rdma_lookup_mode mode,
+			  struct uverbs_attr_bundle *attrs);
 void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 			     enum rdma_lookup_mode mode);
 struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
