Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9623724055A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHJLZs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 07:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgHJLZq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Aug 2020 07:25:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC430C061756;
        Mon, 10 Aug 2020 04:25:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so7803990wro.2;
        Mon, 10 Aug 2020 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oTg2lxBtHTJ9GHQqs1UPfQnOTLFgVN0t8PhdBgnUOZo=;
        b=o9v8vl6sxuZv3OE+NRsrsOpuKAl5e53GHbfTnyCtOZV1p2zAW+cLNzN6HOvnefctsr
         YUQIkHHJaFE5NU1fJ7SddpIUAXlGM5yfm7ystzVLYNJZVa4GuyUSeTxTuRv3m1vlVNz6
         OIKMicdaF4eGlNE8pB8WPUk1fddWOqpq9CLr6FKC44fBF9a8L9WOYqu+YAsiQj+yWKNo
         pZFSVzQEQb4u2obVQcJ+6ZsfNPKru3/Vt9nDGZaeYLShIN07zhyl6g3UZpr+6CZgyNpm
         SGfl0IaUx/eMPL9MOVpnZeQ0ayjoAVhA+T8ClKjAraCJRitMvkZL0sN1piaWHV2TLeGw
         XQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=oTg2lxBtHTJ9GHQqs1UPfQnOTLFgVN0t8PhdBgnUOZo=;
        b=eHoLI0FMB1lozTw0V+hwLwuKWt71aU7imBAU01/tQ1hVXuk2Xxjd1WD+gBMh0fREgf
         +a3ufjhV9BD2ggR56JS9jCCYFdD6ib3CwAmvLWr3Hhig0FlekLnvG0eycAIfcrmPHHCp
         uwlHtr8UzlkkQJkwf+moIlxwCrYFXl5baltjLpkBZyNJldIjX3nVojh06wx53RIzdMuv
         1/DtU8s1dCRyPvHDs+ndl5TYN4U4OoT72uyBwvmkKbCM1gF38evkyBKKAXEYc0NtrFmp
         kXy8QgXXbOSLm3oUfC0eJ2E7nb51OLCi4ftE9/rn/NCiRgJmNkriZHj22WOlb1giBMsH
         GAHg==
X-Gm-Message-State: AOAM530BvTcKQkUflPdwydFlHh61KxbS2p0arrLsQifZd0+LOn0CEzjx
        rDiXhLPbYwJzxgOxvI+gtkmmprRr
X-Google-Smtp-Source: ABdhPJwu7ulsQB2sIxkwOEtiTddoyOl0dMfmiZCjLvbUiY7InajwnIBXsggut18F6II9XAC3RPytGQ==
X-Received: by 2002:a5d:6381:: with SMTP id p1mr23634015wru.112.1597058744166;
        Mon, 10 Aug 2020 04:25:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id h11sm18407755wrb.68.2020.08.10.04.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 04:25:43 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] dma-buf.rst: repair length of title underline
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
References: <20200809061739.16803-1-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7d434810-79bd-89a3-18f8-c5c2a2524822@gmail.com>
Date:   Mon, 10 Aug 2020 13:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809061739.16803-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 09.08.20 um 08:17 schrieb Lukas Bulwahn:
> With commit 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are
> a bad idea"), document generation warns:
>
>    Documentation/driver-api/dma-buf.rst:182: \
>    WARNING: Title underline too short.
>
> Repair length of title underline to remove warning.
>
> Fixes: 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are a bad idea")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

Should I pick it up into drm-misc-next?

> ---
> Daniel, please pick this minor non-urgent fix to your new documentation.
>
>   Documentation/driver-api/dma-buf.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
> index 100bfd227265..13ea0cc0a3fa 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -179,7 +179,7 @@ DMA Fence uABI/Sync File
>      :internal:
>   
>   Indefinite DMA Fences
> -~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~
>   
>   At various times &dma_fence with an indefinite time until dma_fence_wait()
>   finishes have been proposed. Examples include:

