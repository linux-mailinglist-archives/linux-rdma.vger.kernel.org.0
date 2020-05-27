Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EFD1E4AA7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbgE0Qo4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 12:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbgE0Qo4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 12:44:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05705C03E97D
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 09:44:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so1727419pjd.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X64+ppe+q0UNqqvojub0C2NL80dGaMETVbT2rPY1ums=;
        b=Im8qkxh1Sn2M/k9QOosiF7M8y+EZGWRBKzEwgickzvAWQsO0qdxKCCYziWnQH2IZDv
         98cC1QrXHaoXfvzOvquq0qL2AYdROiW9/vjK8+7UwmPWoseg/T0VWfKVI33FGAjmpopz
         Q/TQbqUeduz4FZBP2tMTrmWgILT7RKPwDL2FfdbYZi/584J48q2EtpJ/6Hh8kAXd9QL/
         iOb/7BXZzwHUfGNwHZxXDm01V59p0b+zJU7HSDCt553gKcRtzS43vHzi2j27pajsj7ZP
         4xAW11oOhuYf3a2sfesfwqt0+TNh1+aJQEgtmLtg/5bMiEFji3dAHSEscBTWe7quPnI/
         L7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X64+ppe+q0UNqqvojub0C2NL80dGaMETVbT2rPY1ums=;
        b=A09rZHfEuh1OvggSaU1+IMP1Qy4XN5P/EFBk5ZYN7EtkJ7SnYTzum1VtdPiNaKtzEv
         GqpsP6HeDlyG2fPQ97RwV19ylhVz6Y/C9Xx8/+YlixUAvq/L0UDLpNesL2RoMms0TzJi
         cQur+XGVOyfONml2Dono5o8i5UoJwCJaIYeSb7VLz7te+FYuUw/4CpjJczehQWYJ/ADv
         YUgxnQbd3CUeQLy/gqdsK8ak2DHOyJqDBKJESVE8L+Zk2wismd1YtmG4BcSKt4tYWnr3
         slojoJYn2ml7ThcaVo1w7Me6mvKyZvhgge7Ati2J39TFt98fqA6J8rSUTgYWXZJ4RdUE
         0meQ==
X-Gm-Message-State: AOAM531jFGwPQFV7QaJJq2Og9WWnyImp9CfAoAU+ujnPLGgwW4I4pmF5
        EcTNAK+yEI/r8auhe5Qt9GOE/g==
X-Google-Smtp-Source: ABdhPJz4Zze5uwlMQlM8QS2P8EVI0og3y/PQcOV3bGNjW8YShHlRWlsPUpoc6xp4xKZcyP0VVjVJtQ==
X-Received: by 2002:a17:902:c686:: with SMTP id r6mr6969518plx.147.1590597895475;
        Wed, 27 May 2020 09:44:55 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d15sm3638917pjc.0.2020.05.27.09.44.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 09:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdzAi-0001rU-T1; Wed, 27 May 2020 13:44:52 -0300
Date:   Wed, 27 May 2020 13:44:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] IB/core: Use sizeof_field() helper
Message-ID: <20200527164452.GQ744@ziepe.ca>
References: <20200527144152.GA22605@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527144152.GA22605@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 09:41:52AM -0500, Gustavo A. R. Silva wrote:
> Make use of the sizeof_field() helper instead of an open-coded version.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/core/sa_query.c     | 8 ++++----
>  drivers/infiniband/core/uverbs_cmd.c   | 2 +-
>  drivers/infiniband/core/uverbs_ioctl.c | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

What kind of tool are you using for this? It seems to miss a lot, I
added in a few others to this patch and applied it, thanks:

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8f70c5c38ab7c3..a2ed09a3c714a9 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -420,7 +420,7 @@ static const struct ib_field opa_path_rec_table[] = {
 
 #define MCMEMBER_REC_FIELD(field) \
 	.struct_offset_bytes = offsetof(struct ib_sa_mcmember_rec, field),	\
-	.struct_size_bytes   = sizeof ((struct ib_sa_mcmember_rec *) 0)->field,	\
+	.struct_size_bytes   = sizeof_field(struct ib_sa_mcmember_rec, field),	\
 	.field_name          = "sa_mcmember_rec:" #field
 
 static const struct ib_field mcmember_rec_table[] = {
@@ -504,7 +504,7 @@ static const struct ib_field mcmember_rec_table[] = {
 
 #define SERVICE_REC_FIELD(field) \
 	.struct_offset_bytes = offsetof(struct ib_sa_service_rec, field),	\
-	.struct_size_bytes   = sizeof ((struct ib_sa_service_rec *) 0)->field,	\
+	.struct_size_bytes   = sizeof_field(struct ib_sa_service_rec, field),	\
 	.field_name          = "sa_service_rec:" #field
 
 static const struct ib_field service_rec_table[] = {
@@ -710,7 +710,7 @@ static const struct ib_field opa_classport_info_rec_table[] = {
 
 #define GUIDINFO_REC_FIELD(field) \
 	.struct_offset_bytes = offsetof(struct ib_sa_guidinfo_rec, field),	\
-	.struct_size_bytes   = sizeof((struct ib_sa_guidinfo_rec *) 0)->field,	\
+	.struct_size_bytes   = sizeof_field(struct ib_sa_guidinfo_rec, field),	\
 	.field_name          = "sa_guidinfo_rec:" #field
 
 static const struct ib_field guidinfo_rec_table[] = {
diff --git a/drivers/infiniband/core/ud_header.c b/drivers/infiniband/core/ud_header.c
index 29a45d2f8898e1..d65d541b9a2587 100644
--- a/drivers/infiniband/core/ud_header.c
+++ b/drivers/infiniband/core/ud_header.c
@@ -41,7 +41,7 @@
 
 #define STRUCT_FIELD(header, field) \
 	.struct_offset_bytes = offsetof(struct ib_unpacked_ ## header, field),      \
-	.struct_size_bytes   = sizeof ((struct ib_unpacked_ ## header *) 0)->field, \
+	.struct_size_bytes   = sizeof_field(struct ib_unpacked_ ## header, field), \
 	.field_name          = #header ":" #field
 
 static const struct ib_field lrh_table[]  = {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 5bd2b037e9147c..0418d7bddf3e0c 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -420,9 +420,9 @@ struct uapi_definition {
 		.scope = UAPI_SCOPE_OBJECT,                                    \
 		.needs_fn_offset =                                             \
 			offsetof(struct ib_device_ops, ibdev_fn) +             \
-			BUILD_BUG_ON_ZERO(                                     \
-			    sizeof(((struct ib_device_ops *)0)->ibdev_fn) !=   \
-			    sizeof(void *)),				       \
+			BUILD_BUG_ON_ZERO(sizeof_field(struct ib_device_ops,   \
+						       ibdev_fn) !=            \
+					  sizeof(void *)),                     \
 	}
 
 /*
@@ -435,9 +435,9 @@ struct uapi_definition {
 		.scope = UAPI_SCOPE_METHOD,                                    \
 		.needs_fn_offset =                                             \
 			offsetof(struct ib_device_ops, ibdev_fn) +             \
-			BUILD_BUG_ON_ZERO(                                     \
-			    sizeof(((struct ib_device_ops *)0)->ibdev_fn) !=   \
-			    sizeof(void *)),                                   \
+			BUILD_BUG_ON_ZERO(sizeof_field(struct ib_device_ops,   \
+						       ibdev_fn) !=            \
+					  sizeof(void *)),                     \
 	}
 
 /* Call a function to determine if the entire object is supported or not */
