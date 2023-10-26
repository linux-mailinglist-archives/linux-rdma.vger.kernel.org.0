Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070AD7D86E7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJZQrZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjJZQrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 12:47:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C74E187
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 09:47:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-692c02adeefso1026589b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698338841; x=1698943641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdlXvNC1oH8LpDpUtTg5FvSVkJ8vtx+5H8ZrGXJ1ghc=;
        b=HhVgDKS+/6Qp9UyLmiFRY1h2ZhU1Mo7r9tXKn/ETcmosEa5Y7uMDgVrxRPhvxMNv02
         9yKL6GZSSVOIL5GbTQdiCulm4EyW+qvun8qSCiVS30sNusT6MLfD1ZktERDVC3Qm/+9v
         IegEp9T1KZf0KE3f7SWLmS3eh0DZ02B3alzmFzdCh0nkwH5uRmTAcgkh0As9sjaEoLtn
         1bnKMjgAXxuVQAnxYYoQWsHfu6eRhSGqVyEmZfboAAHng05TS9Bz85B8VAfRMDSJk8je
         7Yd4Shd1EbiHswa/w9bogdExf0N5HogIrwTiiH51Hox5YWO89LADi17W7SljOvMO7184
         Rvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338841; x=1698943641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdlXvNC1oH8LpDpUtTg5FvSVkJ8vtx+5H8ZrGXJ1ghc=;
        b=ll7wKdN4Bf4+ic46z0SwleJtBdBXnv/LJ1mWuozxRL38xx8uh+eGlDsRgZwiKgrBYC
         8vjkHMRhKDmF4jQcvrRy3sCLwKtV+i/apuZPymHrEE6cMi4jXneT0GjMpE8TElDIaPar
         dnYSuq50q0yqaprcRMBDcsza1xTmlEDbfaP5eyjC4yZz92B7A/BUSJi+XrqSE9Ihty4c
         pkXxv9oo0/VxW5NrEfv2q5B3+bEHUOCTJ+nu3zLj8poP7QRNdjCAWQFipswariZelmAD
         hyTMoi9aM7V4UeAM68dsb2rRqF0sWquwwxz9lFRsof8mE7YCKTIJ3LYmrikZuVV2PTUJ
         bRig==
X-Gm-Message-State: AOJu0Yx/kJ0YsxGwIdO6R1qji81nCLGtAnCoHjNHvVxXJ23cKubqIctm
        ffSfe/npojx78pitrTLWJE8agg==
X-Google-Smtp-Source: AGHT+IH8FSwFpW91FuCTU44KJZe03BzdcRhpD6cilALb1W6ubekxWLvOyZfKm3UyQTuWKQaC+rgpBQ==
X-Received: by 2002:a05:6a21:47c1:b0:15d:9ee7:1811 with SMTP id as1-20020a056a2147c100b0015d9ee71811mr334913pzc.36.1698338841412;
        Thu, 26 Oct 2023 09:47:21 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79414000000b006bf53a51e6dsm9749547pfo.179.2023.10.26.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:47:21 -0700 (PDT)
Date:   Thu, 26 Oct 2023 09:47:19 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Message-ID: <20231026094719.04cace95@hermes.local>
In-Reply-To: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
References: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 25 Oct 2023 15:50:50 -0700
longli@linuxonhyperv.com wrote:

> 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
>  		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
> -		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
> -			netdev_notice(vf_netdev,
> -				      "falling back to mac addr based matching\n");
> +		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
> +		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))

This part looks like unrelated change.
The VF mac address shouldn't change, but if it did don't look at i.
