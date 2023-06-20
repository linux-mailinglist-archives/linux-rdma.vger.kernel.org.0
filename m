Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5C736793
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjFTJVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjFTJVB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 05:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C969D
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687252815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKlFS4GRFyLfxQyoUYwSoUhG2vDj3eHL58QXsQUCy8w=;
        b=TJoZZdgC7BODoyqeIKP3hwssyuJ/iv21fUI6NWvbOoaQ89db25qbk2BocZ6O60DnX126Jb
        jIyY5gDqtQs/UUjw4sWXKMOo5BacR2o4WYp3ICU25uxmGz3mOwAXlqSwWGAIk+Y2Jrwo3D
        cfZMRNnH7Gb+FTCxvdaznoaoP1sZhqU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-BBv44A6ZNGCoastg5rsMgA-1; Tue, 20 Jun 2023 05:20:13 -0400
X-MC-Unique: BBv44A6ZNGCoastg5rsMgA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-763a3e3e760so173382985a.0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 02:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252813; x=1689844813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKlFS4GRFyLfxQyoUYwSoUhG2vDj3eHL58QXsQUCy8w=;
        b=bXqm1xm8gP/Ea3I1EcdLvLmRlKEM79MBTTx5cDlA41+hVLYoLUljkQ+E9v5cFfbSTb
         Z5M00Ept7RPcQZ2TAOg1fjcbu+cnh+l0dFHf693d430H8Enq/9C50L+JlkT5BmhPd++W
         Na+2WE8eK2L2xXWioowDzPGUyWAu2Xl21zxkXqGXbFvkyrSvkdXUxELlikNxJz1948iU
         1sEN0UMJyxyVpKcqmvc7htxM9nP6TVeesv1DVxgpotCXKMnWb3qBdMs+X8/KKER5uM5C
         wo6wKx8M0QRXwQiZeubvk5m1gWr0VuIVHV4+tSLEgUIUeJkaYaHwU7yD+9+yT/cU3SYH
         djkw==
X-Gm-Message-State: AC+VfDx8FWmOmiDY42Kr5GSzJaGvqxnhEsHbdspH14BBN8nO17PIQPqg
        wpgoe3nyvZhipDjE4jpynr+w/I9mHX6Z7lgZEqdJnEnH/hEOg6MYVdmwspdPL7R9bMb6ZnDFGni
        J15tiZxQJXzBxVt8ssoHJLdBF1IiMQ8L/FVNvJpc6z8zY9w==
X-Received: by 2002:a05:620a:8f09:b0:762:51c3:cfda with SMTP id rh9-20020a05620a8f0900b0076251c3cfdamr6835859qkn.7.1687252812908;
        Tue, 20 Jun 2023 02:20:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/sXxYZyk7GODk1ZNp9vpi+6jndC87IboxMu7bTkgZZVJfY8XP4cHMFoPK9tp8UGws/TDf5LRnfmj5y/1RwZw=
X-Received: by 2002:a05:620a:8f09:b0:762:51c3:cfda with SMTP id
 rh9-20020a05620a8f0900b0076251c3cfdamr6835849qkn.7.1687252812657; Tue, 20 Jun
 2023 02:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230609153147.667674-1-neelx@redhat.com> <20230613131931.738436-1-neelx@redhat.com>
In-Reply-To: <20230613131931.738436-1-neelx@redhat.com>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Tue, 20 Jun 2023 11:19:36 +0200
Message-ID: <CACjP9X_ONQR53Js301r1WGguMR4hhtDZRkoMJjUMDqX-=yA+1g@mail.gmail.com>
Subject: Re: [PATCH v2] verbs: fix compilation warning with C++20
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adding CC: Jason

--nX

On Tue, Jun 13, 2023 at 3:20=E2=80=AFPM Daniel Vacek <neelx@redhat.com> wro=
te:
>
> Our customer reported the below warning whe using Clang v16.0.4 and C++20=
,
> on a code that includes the header "/usr/include/infiniband/verbs.h":
>
> error: bitwise operation between different enumeration types ('ibv_access=
_flags' and
> 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-c=
onversion]
>                 mem->mr =3D ibv_reg_mr(dev->pd, (void*)start, len, IBV_AC=
CESS_LOCAL_WRITE);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
> /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_r=
eg_mr'
>                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) =3D=
=3D 0))
>                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> According to the article "Clang 11 warning: Bitwise operation between dif=
ferent
> enumeration types is deprecated":
>
> C++20's P1120R0 deprecated bitwise operations between different enums. Su=
ch code is
> likely to become ill-formed in C++23. Clang 11 warns about such cases. It=
 should be fixed.
>
> Reported-by: Rogerio Moraes <rogerio@cadence.com>
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>  libibverbs/verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index 03a7a2a7..ed9aed21 100644
> --- a/libibverbs/verbs.h
> +++ b/libibverbs/verbs.h
> @@ -2590,7 +2590,7 @@ __ibv_reg_mr(struct ibv_pd *pd, void *addr, size_t =
length, unsigned int access,
>  #define ibv_reg_mr(pd, addr, length, access)                            =
       \
>         __ibv_reg_mr(pd, addr, length, access,                           =
      \
>                      __builtin_constant_p(                               =
      \
> -                            ((access) & IBV_ACCESS_OPTIONAL_RANGE) =3D=
=3D 0))
> +                            ((int)(access) & IBV_ACCESS_OPTIONAL_RANGE) =
=3D=3D 0))
>
>  /**
>   * ibv_reg_mr_iova - Register a memory region with a virtual offset
> --
> 2.40.1
>

