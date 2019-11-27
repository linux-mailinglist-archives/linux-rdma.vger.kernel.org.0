Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6910A7A8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 01:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK0AxS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 19:53:18 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:35993 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfK0AxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Nov 2019 19:53:17 -0500
Received: by mail-pl1-f172.google.com with SMTP id d7so8952355pls.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2019 16:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vmaTkXMxrbdFow4O1dinxRByMlpX/XyjAqyAFS/go0M=;
        b=O12m3a5I11TQ3OcuDzqnngXuueQCGGHcxA0At9yhvBfDvhfme9th1GpIzErvmSfgwy
         yVqUf79J4c0Rr8X7nD5u/PMq8siXEmz9iwXShxgAgoF6/nUOIkTh21ZS7NyW3rK0jIEy
         2af3lNJ/7OXkL17CZjY3YLCoQWiCyZ6nPFlIgw5jXk6fGSqT1lKNqXns/wmcHjYt/+jP
         rGNJNSHiaE8Y4SJdl21St3siBVgUO8BnI9UV1ITn8AhxoQgY385WquJ8GiJaAszRtcuO
         2hqOupXk8eIQxRYr8I2tun8ToFW6uRWKHIS1w+VcK2xQL1sVN5Fc2GazLnpvsvD7GD9d
         Iplg==
X-Gm-Message-State: APjAAAVx0IQCneH1UbuUNAn+eAERsfTwAlWhUeH8t9Q8dvLbIDw1qrCa
        tQNr42qYoWnxJ8a6LZ9CXuMi2M8d
X-Google-Smtp-Source: APXvYqyGRfZoE9YmcpcqDngTwSpJPPJvSa7qgQH2VI4DKTWyh21dgSLxP+2kA5Hg3GPr5XBwCJmOCA==
X-Received: by 2002:a17:902:bd45:: with SMTP id b5mr1204077plx.247.1574815996451;
        Tue, 26 Nov 2019 16:53:16 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s18sm14102813pfm.27.2019.11.26.16.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 16:53:15 -0800 (PST)
Subject: Re: [question]can hard roce and soft roce communicate with each
 other?
To:     wangqi <3100102071@zju.edu.cn>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org
References: <53ed2e18-c58e-1e9c-55f8-60b14dfa2052@zju.edu.cn>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4433c97d-218a-294e-3c03-214e0ef1379f@acm.org>
Date:   Tue, 26 Nov 2019 16:53:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <53ed2e18-c58e-1e9c-55f8-60b14dfa2052@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/21/19 11:19 PM, wangqi wrote:
>      Do you know how to make soft-roce (on server) can send message
> to the hard-roce (like Mellanox cx4 card) on a client? We tried rdma-core
> 25.0 and 26.0. The rdma-core can support both soft-roce and hard-roce.
> 
> But it seems that the soft-roce (server) and hard-roce (client) can not
> communicate via "ib_send_bw", "ib_read_bw" and so on, but can
> communicate via "rping".
> 
>      Do you ever try to use soft-roce and hard-roce together?
> Do they work well? I really wonder why they can not communicate with
> each other. Best wishes,

I think this should be possible. The diagram on the following web page 
shows a RoCE NIC and softROCE connected to each other:

http://www.roceinitiative.org/software-based-roce-a-new-way-to-experience-rdma/

Bart.
