Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B54D3615
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2019 02:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfJKAeH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 20:34:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45717 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJKAeH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 20:34:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so11400909qtj.12
        for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2019 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Ir1jRSeCWH2x6xvXc8uL8ybXkWpvILfmaQVgM2wRfvA=;
        b=N/NiHW61NL9pl0vSynqNPKg+47CTftTAZJrCeaKJfjBsZQsGZbA8sq8jZPvlPRspj3
         +y9R41RMgNMVvFxYKy26KTQCe+od85PboWA8bWr0RfnsIQlkyjqx/wGvHDhEMCqamHsU
         9G7vXzxRBYHTZmgJTnxOXLA+plvbFYf/p9ieYG2s/k9OecB/ezF4A96KHhDM8hQxvtbp
         kKWhlMutOrHtnnOgwcfyPDt4hTz8osq0GKXPY+qrRPVY8Cc0t5lRHnNm0T9Axq6qYljB
         RfHHcJvZC1XMehq73B8DwGn8FKLMblhE99UM5nhqImqrx+5YVYUVEUc8Wcw8mRLGPWN7
         a1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ir1jRSeCWH2x6xvXc8uL8ybXkWpvILfmaQVgM2wRfvA=;
        b=AmjCdCaJmLOglLiyrfZmZFxpKWiYjZv0VK9dLm9yGw80gPdU7qGgCxP8gpA7Lg5DjE
         8ZUxqCEkH78xFxfoJE3gcagT+moryfOyA7KrKBAekcz303rG8dAMT5unoguBkaLXDk0G
         D7UjZREX4F/o8bwH831eg6iuAD/ihGbndJkLxv7wIGl87lLRmrEgPSXWM8wAteW1dm61
         5kh+9fE4cEyQgUlG3gqQEI7974zXw4tHDQrmewE8l787xEkOCk/zWSVJzW+S3fR5Nc+m
         nnpurkDxQWCCB0PPEkUNlUjlRbTJ98EhMjSQ0BiM/X75gpEgAPPlXXB1dPE5nMLxzAA9
         jVFQ==
X-Gm-Message-State: APjAAAUbJ/EibRH2L+WnIC9VPSE9vGzSYfHIU3/M5Sb9f+udcVPrCB5U
        jhh2JwFfXuvGSAToo/N1kKSEPg==
X-Google-Smtp-Source: APXvYqxLt8bpwBFRHaQ/ptEWq7ZJhKNvIocjzEh92WCjqtn0q+SHst81ezrPpSRnVrvXXCwdTmZgLg==
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr13728484qtp.195.1570754045532;
        Thu, 10 Oct 2019 17:34:05 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m186sm3151805qkd.119.2019.10.10.17.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:34:05 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:33:48 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Tal Gilboa <talgi@mellanox.com>,
        David Miller <davem@davemloft.net>, linux-doc@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH] Documentation: networking: add a chapter for the DIM
 library
Message-ID: <20191010173348.1836f23f@cakuba.netronome.com>
In-Reply-To: <c3eab338-f3a9-bff3-4c24-edeb3f80b7cd@infradead.org>
References: <e9345b39-352e-cfc6-7359-9b681cb760e8@infradead.org>
        <20191010162003.4f36a820@cakuba.netronome.com>
        <4c7f5563-2ca1-d37b-7639-f3df99a0219b@infradead.org>
        <20191010165828.0540d18d@cakuba.netronome.com>
        <c3eab338-f3a9-bff3-4c24-edeb3f80b7cd@infradead.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 10 Oct 2019 17:01:02 -0700, Randy Dunlap wrote:
> > Will you try to convert and integrate the existing file instead, or do
> > you think the kdoc file should be separate?  
> 
> I'll take a look at doing that.

Thanks!
