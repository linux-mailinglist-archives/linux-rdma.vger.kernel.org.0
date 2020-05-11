Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FFC1CD43D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgEKIuu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 04:50:50 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55446 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgEKIuu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 04:50:50 -0400
Received: by mail-wm1-f51.google.com with SMTP id e26so17134020wmk.5
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 01:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=Gsbo/15n2L1qD3TzwGcY8QGh4aHO0rfrGE+L3giwbz3zqdOrqYExW+3toL8AK9Fnh/
         5KAdCW0pm8tE3cq+L5Ts44Nt5nbL6PTNzDq0pifuHRzBxUrvdYMp43TmBStP+TRebJmH
         TFLS3xMv9I9Hx7G/LZ3HKTGDIFCzTNGGRXU70LGbYm9OQFzA7KU0346LyxDaP0QuifpJ
         TrmrGxS9I/ErMOAEKxRjlbM//KwDotm3k7cD29cG34I/duCgX1McNCMPRbeE/q91cOxc
         G6CCmqFSu0PhR4bs88BjInY+KxBkzJgEaZWOR8IAq95pRmX1u5DvHcP+sKgR2k5OjHk5
         O8Bw==
X-Gm-Message-State: AGi0Puaoaf/W90jwIBVljdc6ixEPVrBJ0cuyVeq4DErMwtrPcrERYsM6
        GXc+W2zXbJq8HcQH98JuJRkuSt+N
X-Google-Smtp-Source: APiQypKQa4IUZVgC2ucckzyIrN+fL+mCNcjyVh2l+1NEKnqDHpjS4GpX9Im30x7Qwy9V6grP4snk4g==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr22050296wmj.100.1589187047999;
        Mon, 11 May 2020 01:50:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59c:65b4:1d66:e6e? ([2601:647:4802:9070:59c:65b4:1d66:e6e])
        by smtp.gmail.com with ESMTPSA id 2sm16377323wre.25.2020.05.11.01.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:50:47 -0700 (PDT)
Subject: Re: [PATCH 4/4] nvmet-rdma: use new shared CQ mechanism
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-5-git-send-email-yaminf@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e42e4063-8789-3a69-d733-26521c31a4c2@grimberg.me>
Date:   Mon, 11 May 2020 01:50:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589122557-88996-5-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
