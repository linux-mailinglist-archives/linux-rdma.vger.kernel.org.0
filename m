Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A6364C3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFETeg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:34:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36269 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFETeg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:34:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so1858902otr.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=f5eL1ejSW0D82EDVqVYn9p8SGgG8vHETKWW2l38EKglKaply7em6dJXfPuZCD/EkS3
         2RriN0iQ6qUlp5k33cDSVNdBqPFbU2E6a2OplJ3W1FUerD5+SO9CiQQVlQNskQXMoG5m
         jHWWJQf01TSPxLTb88Zr4F5aZrahrFOnTLoVQzX2V7mDu2M9qPu/rkUECz0fbLDewVSO
         nasE+8z07UzRVusG/XmlDFJHoF0dwpu8uRMwgKHdxw2Zz+v1Om+lLJB/egWperIr7oGL
         EmG+ezO83dYrjk8c5C98x+Ph/qX0LtQfbasIN58xXh8fb1VqqzbWqof6QqftdrCVRHDj
         tWsg==
X-Gm-Message-State: APjAAAWPLrM9r7sl/Tr1QXEwUSPPfnYuLK3YxKLEvfVnVG1Ef6UkBNOi
        v9RHZlucBATFcroD4VP9oTw=
X-Google-Smtp-Source: APXvYqybMRfdxuGhWtZmIZaCQyZF9hslnxpUv4UE73Rag/qvrXe9gYj35d133lsAe89rhZ0gf5tj0Q==
X-Received: by 2002:a9d:7348:: with SMTP id l8mr537405otk.111.1559763276092;
        Wed, 05 Jun 2019 12:34:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o10sm8015621oif.53.2019.06.05.12.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:34:35 -0700 (PDT)
Subject: Re: [PATCH 12/20] IB/iser: Unwind WR union at iser_tx_desc
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-13-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <984ed18c-5c90-945a-bd81-a63a9d3b6306@grimberg.me>
Date:   Wed, 5 Jun 2019 12:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-13-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
