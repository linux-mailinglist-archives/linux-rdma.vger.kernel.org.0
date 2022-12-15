Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9807A64DDB5
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 16:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiLOPVd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Dec 2022 10:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiLOPVA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Dec 2022 10:21:00 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E7362E5
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 07:19:27 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso3775671otn.2
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SS7FD5UcGJIKcui9D+/OEcfu0gF7xKPbG9AxsHECMEo=;
        b=U4/vgcAvUx/AwoxydS2Vtrp6YPn7MI9dA7rQfX2SWdDVNjMvHOcjhEHr1MnVbUFeZ8
         jxxK5UIpeELFMY2NVm2m+72uIFrItJuWe1pPTgUuaFb4yHEBu9Tux1AeK3Thfhq2502l
         t4zernnd/qUZvChYItG/PtZ45JPBKoLsAoqYUN+vXFXRu8+ERSOikdA3hu/2EV/KtTev
         E9S2TAWB3Hw+HG/VvoXkhRrsm02M+zFN+/yxpXgRgdt7feHECD+vVrRq1Tza2QK4yQYr
         tHz3oax3n2f+jf8MhI+WcU1+3S2UiVCTRSf7UtEDquHpRzaKbdcCJUdm2gdvjiCnZNdo
         CGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS7FD5UcGJIKcui9D+/OEcfu0gF7xKPbG9AxsHECMEo=;
        b=D4fYdzyW0NX6gKjmlbQ2U3Y2HZhM/rPQYUnFaVC9GdYiVh0h3wIXtD5k9bBB5mAyUx
         sPCQ0GM4dalYkXxaRYMU/5NMPLx3C0QodvmVRb4faASaheKe801VyT1z+AxJm2dkT5D0
         mFtZ9uOtKY0DeyJC5k+rKlY8ieAIzhjUu+zKgB0DPE5f11V+F0N93Yqa7QEFDj/QMVWa
         5oLBlDMinl/L9npZfpq1mWZQFpdLI6MBQErHaYTvWMvhlQbELgeAaanMgICwDfRYzpA/
         OEw1DprGvgGW3pibBSMvazRHNLQkZP8iB1U9GOGPlZtL3ywkiyXuYbO39QecWEKi4h4a
         MJNQ==
X-Gm-Message-State: ANoB5pnDcJ+wj6UwvPB8ug66eRYC4K7lA8j4ZEeyTq9WkPCsO9Z+3UwM
        RDNU79rkf/PY/ymSTp0K89Q=
X-Google-Smtp-Source: AA0mqf52MZp4QLvPGNxPDIfeQVkGX5Lfqkgrg2pZJTtD/y3+riFc9pemp/4qO/lMR3OVtnMKI66TJw==
X-Received: by 2002:a05:6830:349f:b0:66e:c096:126c with SMTP id c31-20020a056830349f00b0066ec096126cmr13593528otu.29.1671117566339;
        Thu, 15 Dec 2022 07:19:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h22-20020a9d6f96000000b0066cb9069e0bsm3693532otq.42.2022.12.15.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:19:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 15 Dec 2022 07:19:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com, rpearsonhpe@gmail.com,
        leon@kernel.org, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        zyjzyj2000@gmail.com
Subject: Re: [PATCH v7 6/8] RDMA/rxe: Make responder support atomic write on
 RC service
Message-ID: <20221215151924.GA2574647@roeck-us.net>
References: <1669905568-62-1-git-send-email-yangx.jy@fujitsu.com>
 <1669905568-62-2-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669905568-62-2-git-send-email-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 02:39:26PM +0000, Xiao Yang wrote:
> Make responder process an atomic write request and send a read response
> on RC service.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---

On all 32-bit builds with CONFIG_WERROR enabled:

Error log:
drivers/infiniband/sw/rxe/rxe_resp.c: In function 'atomic_write_reply':
drivers/infiniband/sw/rxe/rxe_resp.c:794:13: error: unused variable 'payload' [-Werror=unused-variable]
  794 |         int payload = payload_size(pkt);
      |             ^~~~~~~
drivers/infiniband/sw/rxe/rxe_resp.c:793:24: error: unused variable 'mr' [-Werror=unused-variable]
  793 |         struct rxe_mr *mr = qp->resp.mr;
      |                        ^~
drivers/infiniband/sw/rxe/rxe_resp.c:791:19: error: unused variable 'dst' [-Werror=unused-variable]
  791 |         u64 src, *dst;
      |                   ^~~
drivers/infiniband/sw/rxe/rxe_resp.c:791:13: error: unused variable 'src' [-Werror=unused-variable]
  791 |         u64 src, *dst;

Guenter
