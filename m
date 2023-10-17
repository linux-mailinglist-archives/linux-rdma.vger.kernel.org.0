Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7967CBD05
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 10:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjJQICg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 04:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQICe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 04:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9235AB
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697529713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQ117M2jgWxUnJUj7fuhzPSTEiiTZHHq+ID/a06/KdQ=;
        b=UXcE9gxz1SUEV4CbSN78iJQTYe3cXRy5Z5YcqPHzqKri8F4jiSTar8DBl3NWe88Jnvg6oG
        CMKrGpPqbkbcbYr2elbbvwV5lhomIHwpBWFPgIbnxwB35wSK8IZK/CysjVuIR7+aHobGWH
        tu76oJobxDPZ/8d9puZbHiXVmR85Txg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-MoCXtgqUP5m-Iakgk_dpRQ-1; Tue, 17 Oct 2023 04:01:43 -0400
X-MC-Unique: MoCXtgqUP5m-Iakgk_dpRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34334185A797;
        Tue, 17 Oct 2023 08:01:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE234492BF3;
        Tue, 17 Oct 2023 08:01:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id A799421E6A1F; Tue, 17 Oct 2023 10:01:41 +0200 (CEST)
From:   Markus Armbruster <armbru@redhat.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH rdma-core] libibverbs/man/ibv_reg_mr.3: Document errno
 on failure
References: <20231017053738.226069-1-lizhijian@fujitsu.com>
Date:   Tue, 17 Oct 2023 10:01:41 +0200
In-Reply-To: <20231017053738.226069-1-lizhijian@fujitsu.com> (Li Zhijian's
        message of "Tue, 17 Oct 2023 13:37:37 +0800")
Message-ID: <874jipd6e2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Li Zhijian <lizhijian@fujitsu.com> writes:

> 'errno' is being widely used by applications when ibv_reg_mr returns NULL.
> They all believe errno indicates the error on failure, so let's document
> it explicitly.

Similar issue with ibv_open_device() .  Possibly more.

> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  libibverbs/man/ibv_reg_mr.3 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
> index 8f323891..d43799c5 100644
> --- a/libibverbs/man/ibv_reg_mr.3
> +++ b/libibverbs/man/ibv_reg_mr.3
> @@ -103,7 +103,7 @@ deregisters the MR
>  .I mr\fR.
>  .SH "RETURN VALUE"
>  .B ibv_reg_mr() / ibv_reg_mr_iova() / ibv_reg_dmabuf_mr()
> -returns a pointer to the registered MR, or NULL if the request fails.
> +returns a pointer to the registered MR, or NULL if the request fails (and sets errno to indicate the failure reason).
>  The local key (\fBL_Key\fR) field
>  .B lkey
>  is used as the lkey field of struct ibv_sge when posting buffers with

We should double-check errno is set on all failures.  I doubt it is.

ibv_reg_mr() is a macro:

    #define ibv_reg_mr(pd, addr, length, access)                                   \
            __ibv_reg_mr(pd, addr, length, access,                                 \
                         __builtin_constant_p(				       \
                                 ((int)(access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))

__ibv_reg_mr() may call ibv_reg_mr_iova2():

    __attribute__((__always_inline__)) static inline struct ibv_mr *
    __ibv_reg_mr(struct ibv_pd *pd, void *addr, size_t length, unsigned int access,
                 int is_access_const)
    {
            if (is_access_const && (access & IBV_ACCESS_OPTIONAL_RANGE) == 0)
                    return ibv_reg_mr(pd, addr, length, (int)access);
            else
                    return ibv_reg_mr_iova2(pd, addr, length, (uintptr_t)addr,
                                            access);
    }

ibv_reg_mr_iova2() doesn't seem to set errno at --->:

    struct ibv_mr *ibv_reg_mr_iova2(struct ibv_pd *pd, void *addr, size_t length,
                                    uint64_t iova, unsigned int access)
    {
            struct verbs_device *device = verbs_get_device(pd->context->device);
            bool odp_mr = access & IBV_ACCESS_ON_DEMAND;
            struct ibv_mr *mr;

            if (!(device->core_support & IB_UVERBS_CORE_SUPPORT_OPTIONAL_MR_ACCESS))
                    access &= ~IBV_ACCESS_OPTIONAL_RANGE;

            if (!odp_mr && ibv_dontfork_range(addr, length))
--->                return NULL;

            mr = get_ops(pd->context)->reg_mr(pd, addr, length, iova, access);
            if (mr) {
                    mr->context = pd->context;
                    mr->pd      = pd;
                    mr->addr    = addr;
                    mr->length  = length;
            } else {
                    if (!odp_mr)
                            ibv_dofork_range(addr, length);
            }

            return mr;
    }


Thanks!

