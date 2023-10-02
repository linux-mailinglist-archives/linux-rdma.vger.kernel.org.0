Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC85F7B5C9A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 23:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjJBVph (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 17:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjJBVpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 17:45:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA760CE
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 14:45:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406609df1a6so2486095e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Oct 2023 14:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1696283130; x=1696887930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dA79LkNYU7asBXwt/uQxW8bheOGwedQNE5Z+nFIVT0=;
        b=jC4WA2n5N6fh0h+8A80v34J674kTNb/dkqkkQ4wr6AQU33VVyNhBrLJ5fIDHvQkiRC
         YGLtDdF8yOE+UQ1F9TDhWiCE0v6E1PqR6ceCh6wN4S6/wW6QSdK3FhOoyU/zI1HpFs0O
         +F8KfczwTGXQlzUVF4ka2LhahMo5RG2sNqhG8NaTCIin4KK5EYb9i1itvP4TT4QtItrG
         6l81HyN+/AWlJTwrcZBsVzzV6zShJd0lbmT0bslRid9k+F5TLRs7b1Nah9+yNFpY15j8
         CilWH5jhV7Apb9r2YfgO6KBYqg0XMY4yHLusxDU82pYXfBi6WeD9aJ2bVZr42E3kPHhV
         fbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696283130; x=1696887930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dA79LkNYU7asBXwt/uQxW8bheOGwedQNE5Z+nFIVT0=;
        b=EBqPqJRtn5pkwjuEI85mzRqOUYkCbsbqdb6HImJTAQ7iVQpEs1D/GZ93Jofd6AWsUM
         +cYU04AtcjbMEfWYdqHT9QqFSrAQVyPbi8XIHbeJ63aOFBL5ivYDPp1SO5C0wtrQIgzo
         nco+l9cw3S3hYruYDUIfmjGKmLobhh6a/5YA4hD5lrF4ZY52vrCmBiilnNmIITfqkw9P
         ArtEZ344p2/JtOeYR7IStfhCdqCaxVdr/a7767nh9j+5ybaI8CvAavTpxVAm0OpPWKwv
         KZfPaPw+w07fLPEPg0hlD87MAFmongoyU4wAJpx24iWxh1bw6r/4smLIokMxLlLq7i98
         MKYQ==
X-Gm-Message-State: AOJu0YwPbLdN2sy2uB61QVJpukHO58hL2unic5yKIvBPaIs8lfM0kz+b
        8ROdCh1eMcWpsJ1aaMIH8fXjpQ==
X-Google-Smtp-Source: AGHT+IFQqDHrxS5nLVVcz3uYz3zBoh8PRAUblObfkXMiu+127hGE3d4cKV4jcsCeAwYclm/ssvuz7g==
X-Received: by 2002:a1c:6a05:0:b0:404:757e:c5ba with SMTP id f5-20020a1c6a05000000b00404757ec5bamr10282866wmc.26.1696283130281;
        Mon, 02 Oct 2023 14:45:30 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c2d4b00b004065daba6casm7974630wmg.46.2023.10.02.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 14:45:29 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     devnull+j.granados.samsung.com@kernel.org
Cc:     Jason@zx2c4.com, airlied@gmail.com, arnd@arndb.de,
        clemens@ladisch.de, daniel@ffwll.ch, davem@davemloft.net,
        decui@microsoft.com, dgilbert@interlog.com,
        dri-devel@lists.freedesktop.org, dsahern@kernel.org,
        edumazet@google.com, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, intel-gfx@lists.freedesktop.org,
        j.granados@samsung.com, jani.nikula@linux.intel.com,
        jejb@linux.ibm.com, jgg@ziepe.ca, jgross@suse.com,
        jirislaby@kernel.org, joonas.lahtinen@linux.intel.com,
        josh@joshtriplett.org, keescook@chromium.org, kuba@kernel.org,
        kys@microsoft.com, leon@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        martin.petersen@oracle.com, mcgrof@kernel.org, minyard@acm.org,
        netdev@vger.kernel.org, oleksandr_tyshchenko@epam.com,
        openipmi-developer@lists.sourceforge.net, pabeni@redhat.com,
        phil@philpotter.co.uk, rafael@kernel.org, robinmholt@gmail.com,
        rodrigo.vivi@intel.com, russell.h.weight@intel.com,
        song@kernel.org, sstabellini@kernel.org, steve.wahl@hpe.com,
        sudipm.mukherjee@gmail.com, tvrtko.ursulin@linux.intel.com,
        tytso@mit.edu, wei.liu@kernel.org, willy@infradead.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 01/15] cdrom: Remove now superfluous sentinel element from ctl_table array
Date:   Mon,  2 Oct 2023 22:45:28 +0100
Message-ID: <20231002214528.15529-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-1-02dd0d46f71e@samsung.com>
References: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-1-02dd0d46f71e@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> Remove sentinel element from cdrom_table
>
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/cdrom/cdrom.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index cc2839805983..a5e07270e0d4 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -3655,7 +3655,6 @@ static struct ctl_table cdrom_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= cdrom_sysctl_handler
>  	},
> -	{ }
>  };
>  static struct ctl_table_header *cdrom_sysctl_header;
>
>
> -- 
> 2.30.2


Hi Joel,

Looks good to me, many thanks. I'll send on for inclusion.

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
