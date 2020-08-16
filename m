Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C52459F1
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 00:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgHPWsw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Aug 2020 18:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgHPWsv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Aug 2020 18:48:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE027C061385
        for <linux-rdma@vger.kernel.org>; Sun, 16 Aug 2020 15:48:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so597051plp.4
        for <linux-rdma@vger.kernel.org>; Sun, 16 Aug 2020 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VM0H+i2XPK4MbOrtTltmOP8Bs+Atjze++mkZMKipU7g=;
        b=tHsurezvrPAhLHzJibR3lzC5sminKYWguVd4x9uBXKejD/JkMVMqwzrULatW4Mb2Tm
         RrLcga1/68JZmRy71Cqd7wm98F2qopQE3Nkvvb+eUkjHFdKdoCeHHWJx2M7qkG7MErPx
         /VeYha0sNvJIeOfYy6CKcBOY6g6WlU9ntC1RAiSgAwj5KYCJR+hdSMk1e5zzogsSb7m5
         dMyRnqYHrl4qANysJ6OpLvTvZzMatEy/Tn59Ft5vlIvQXWCpLvdDuCvAnQCUzAG36lfg
         dIsLcD5EPN7GBdq5QbgwUoks28746HB7y53nWfPfW/fcN5S4wGIqw2VMQLtuPoHVjPsu
         sS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VM0H+i2XPK4MbOrtTltmOP8Bs+Atjze++mkZMKipU7g=;
        b=SW5VoXmyrvBXF1irCiOfmm3RiUtMpdgoga0bDn79XyBqLQcfTNQKRqT9CssHDFyfC/
         pWS+C/SdyN1itV6y8EFQG6sF65RxBHynV9iq6ajvPmNWCt0r+TC++fi6IuwG8hlElXDL
         9aqfr8HTP4U5u1DUrL79OLguqYZZ+ZbgzspFMcDU66OEM64uvOUBnXYiVWZdJZ2k9iJc
         Ok5h/hvSTqrEtv/nyScXa1pP+WmvUBLG+xq3tKwavOEdNr7XwtAxIkn5oHyt13vP6FuH
         M4wayapZOHh/oFJYeYErvoYHhJIhtGnnSR4/WI2GWJn4sYeMX1QxOvW+OPv7M/uQpWEt
         cUXA==
X-Gm-Message-State: AOAM533n5G6duXCePYQPOBQ+SaG7tPrF8EgdySiKbnC4NzEMOb7eONWn
        ecVXFl93Qfw/UXX4Wua3vsZn+Jfs3aPy9Q==
X-Google-Smtp-Source: ABdhPJxhWmxI1w1SrW6VWm5XsMpqlgCYk+pveH+UsRghTcv0V5qXw0PZuZ5NuerZyscUv8g678Kmbg==
X-Received: by 2002:a17:902:b18e:: with SMTP id s14mr2018521plr.160.1597618130038;
        Sun, 16 Aug 2020 15:48:50 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c2sm14397373pgb.52.2020.08.16.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 15:48:49 -0700 (PDT)
Date:   Sun, 16 Aug 2020 15:48:46 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     David Ahern <dsahern@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH iproute2-rc v1 2/2] rdma: Properly print device and link
 names in CLI output
Message-ID: <20200816154846.63ebf57c@hermes.lan>
In-Reply-To: <20200811073201.663398-3-leon@kernel.org>
References: <20200811073201.663398-1-leon@kernel.org>
        <20200811073201.663398-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 11 Aug 2020 10:32:01 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> +	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", "dev %s ", name);

Since this is an interface name, you might want to consider using COLOR_IFNAME?

I will go ahead and apply it as is but more work is needed here.
