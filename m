Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32AB1CD43E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgEKIu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 04:50:57 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40311 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgEKIu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 04:50:57 -0400
Received: by mail-wr1-f42.google.com with SMTP id e16so9851153wra.7
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 01:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=AxlFGcs2JFsKP4IFPTpz3ux5zugZXRZjPZlbAlgZrpuzj4kysRVjyrMeh1CWtzw8yI
         z59V51dOb+NFzBFRSdZBcTYUznfS+GFPZ6UnK/Bt/ZEjEjgTgeAJwJ7Fa5Wg9Ci9upHL
         2CtpgxODwByB28iFPvDeeCsutY04HCUfiWw6SpPOvruSFZeunMeebN0K23mh8LmMd9FL
         eQUO6VifM1snZ9pRrVOmtyVmjh0Aok4jaNHWYcN6TNerzUY6zxkMWichWmDKSOQlfVKZ
         HN0VmtuVhTQnXyOK7VRF8pbg1L+l0Ni3qt5vNQyuZ5muG0FvC/XDi6TMEIX8gn6P3zrv
         njHQ==
X-Gm-Message-State: AGi0PuZP3/UwO5Cdq1fO6U6YuBirgF6W38y4gcinjmLOwya+wgS+M9lc
        xl5ICFbK7LQVOezOrZhhMBdGsAYh
X-Google-Smtp-Source: APiQypKTXD7IAqyPB0R5a1QuqfUe90os5qYoNxrf6ZSk+jCOv+Kl7HVdu/LBWgPA+BIFQseCM6LOCw==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr17982691wrq.121.1589187055222;
        Mon, 11 May 2020 01:50:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59c:65b4:1d66:e6e? ([2601:647:4802:9070:59c:65b4:1d66:e6e])
        by smtp.gmail.com with ESMTPSA id l16sm15830507wrp.91.2020.05.11.01.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:50:54 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme-rdma: use new shared CQ mechanism
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-4-git-send-email-yaminf@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <62bf28c2-3ce4-6598-5eaa-13a757ddb3ba@grimberg.me>
Date:   Mon, 11 May 2020 01:50:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589122557-88996-4-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
