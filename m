Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2240E241DA4
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgHKPy0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgHKPy0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 11:54:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF25C061787
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 08:54:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so7832840pfb.10
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fhl0qd9L4Iyh7kowh7z5IJ0kKQPAd9m37zbL3d8utg=;
        b=J5CKK+EpCCZ7D4+YippUYTtEE+lvcjvHpzEFdsq7SEyo8XzT7jAgRmDr5Q7XROncM1
         IEFUG5uLAdPecYQBstnrjooof564temO0QyqpHR2y/oTHP+v8S4S29cF4TScHdpmeRyO
         bP0jq19Ic9pTgpkIHNfXudnMKcX0bWEYhc/td4+icmd0wwi+0WYtDiwPXZawt5zok7Hu
         /hG2Oc0Tr9xuJ4lDXwII14TQfT71Ag6iAFpxSZVIn24YVdgoX2NN8jbXd2yNR4gMSASl
         QGep4t4cMjFSih9O5+LZc2whR+pdlSz6YcZVhBkuPOLSXVMMIZWIVyJbxaePyDkBaHzq
         C8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fhl0qd9L4Iyh7kowh7z5IJ0kKQPAd9m37zbL3d8utg=;
        b=T/3nTuMqIiFKxjwGAuddhFeEC8vR8QSyjt+iEO0bgORR9lPuezmCQghQzCdIF86/oD
         ZdS28iRlhjugiBFh/24HJyMwAo8nhBx7Ss/nXRI8Z/6XVsVa2Vp6ORHp+ZhUKg8Npjwa
         ieRq5X8zGlZ6labj6pvWO59HvtiSCktt0DsHXKGvdXuOPSjpgjjIeTLrHLCDyj4NX5rI
         dLSf/ceUXiNFbgF+qndvVwxN/mX39UmthjvPbZY3aLCJZxxwmd3DR5tz42ZLojH4tVQQ
         7Dn1+KmufSb5E67DhaIT0i7c2CHbD7xtJ5AYIoVu80RTSOa6ftyzdKdUhNbdE8R4w0Rs
         CpDg==
X-Gm-Message-State: AOAM5322tsYOjl9FYTSZAcvOojXPO2860n+DeBqwWJ8BidXK2a3CbVfq
        bkGwuTdf8b6Ff9ccNMMHBMRMMQ==
X-Google-Smtp-Source: ABdhPJwQtpA9ebHOqI6ANWnetQqzj3s0ipYXi+fWw9qZ/PMFUczZQemhvORo0+JjaoZlm0/+a53vCQ==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr6574549pfd.181.1597161266012;
        Tue, 11 Aug 2020 08:54:26 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id jb1sm3435431pjb.9.2020.08.11.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:54:25 -0700 (PDT)
Date:   Tue, 11 Aug 2020 08:54:17 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     David Ahern <dsahern@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH iproute2-rc] rdma: Fix owner name for the kernel
 resources
Message-ID: <20200811085417.5a3dc986@hermes.lan>
In-Reply-To: <20200811063304.581395-1-leon@kernel.org>
References: <20200811063304.581395-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 11 Aug 2020 09:33:04 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> +	print_color_string(PRINT_ANY, COLOR_NONE, "comm", "comm %s ", tmp);

If you don't want color then just print_string will do the same thing.
	
	print_string(PRINT_ANY, "comm", "comm %s ", tmp);


	
