Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD151CD40B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgEKIes (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 04:34:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36248 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgEKIes (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 04:34:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id w19so3375254wmc.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 01:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k6/z5sPgibHV+iu+3QW0wk2/FCmDgTLzbdzSLyRQUQQ=;
        b=hdPNGAR7lVVs76V7ubKXmV0aVPgy6nHBw82roktsZWHKyfs+szKoqZ0D6O2PKGU/sM
         oDvMA5J0Q0ShpjGBhM7zVb03rmvNpQYQ170Y5OODJxeCWjw11wBUmWR4kZE/4kWZ7Twm
         t3MkzEbMF9AZYOlsj77Vh6pTWhLJR+/SkFtSNWBKBc29Jc0hmoNyq9BK+39PuERM00ot
         UaRY+6Jz6SUdDuTcOOcZffad/7RqcsLDqGcvy2o3KaklndNs/w7LA/tEpHIBipns16dk
         5cDIGDYncEVkdQSCDDZFVEDuMxYprqJRszsJXWuTTX/sLNVfM1m+d7tCNrJvoDAOj+OB
         R9QQ==
X-Gm-Message-State: AGi0PuYbsss60aKcjQrRqNY/NXKaJZQ3XWoN9mPJvl8fW/aTmTWG8j2e
        9C599Tb4NUYKNWlLEK09DYfGTH07
X-Google-Smtp-Source: APiQypJdndxAloERfRhW/puDh5jLYjUkHFCm7TyiNf5cH7anybUw8KBDFY0hZAsQ0puvD56tnpqN0w==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr6905839wmf.103.1589186083225;
        Mon, 11 May 2020 01:34:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59c:65b4:1d66:e6e? ([2601:647:4802:9070:59c:65b4:1d66:e6e])
        by smtp.gmail.com with ESMTPSA id p4sm5742089wrq.31.2020.05.11.01.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:34:42 -0700 (PDT)
Subject: Re: [PATCH 0/4] Introducing RDMA shared CQ pool
To:     Yamin Friedman <yaminf@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d2368586-c10a-8c6a-cf52-57eb05b3f8aa@grimberg.me>
Date:   Mon, 11 May 2020 01:34:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey Yamin, thanks for picking it up!

> This is the fourth re-incarnation of the CQ pool patches proposed
> by Sagi and Christoph. I have started with the patches that Sagi last
> submitted and built the CQ pool as a new API for acquiring shared CQs.

Can you also enumerate what changed in this version?

> Our ULPs often want to make smart decisions on completion vector
> affinitization when using multiple completion queues spread on
> multiple cpu cores. We can see examples for this in iser, srp, nvme-rdma.

I'd really like to see some love for the rest of our ulps. I'm not as
involved as I used to be, but it still annoys me a little. You guys
sometimes have a bad habit of centering improvements around nvme(t)/rdma
instead of improving the rest of the kernel consumers. Just one's
opinion though, so its up to you if you want to take it or not...

> This patch set attempts to move this smartness to the rdma core by
> introducing per-device CQ pools that by definition spread
> across cpu cores. In addition, we completely make the completion
> queue allocation transparent to the ULP by adding affinity hints
> to create_qp which tells the rdma core to select (or allocate)
> a completion queue that has the needed affinity for it.
> 
> This API gives us a similar approach to whats used in the networking
> stack where the device completion queues are hidden from the application.
> With the affinitization hints, we also do not compromise performance
> as the completion queue will be affinitized correctly.
> 
> One thing that should be noticed is that now different ULPs using this
> API may share completion queues (given that they use the same polling context).
> However, even without this API they share interrupt vectors (and CPUs
> that are assigned to them). Thus aggregating consumers on less completion
> queues will result in better overall completion processing efficiency per
> completion event (or interrupt).

Have you experimented this? IIRC that was the main feedback from the
last version way back. Have you measured the affect of this? It makes
sense to me that it is beneficial, but probably would be worth to
measure it.

> An advantage of this method of using the CQ pool is that changes in the ULP
> driver are minimal (around 14 altered lines of code).
> 
> The patch set convert nvme-rdma and nvmet-rdma to use the new API.
> 
> Test setup:
> Intel(R) Xeon(R) Platinum 8176M CPU @ 2.10GHz servers.
> Running NVMeoF 4KB read IOs over ConnectX-5EX across Spectrum switch.
> TX-depth = 32. Number of cores refers to the initiator side. Four disks are
> accessed from each core.

What does this mean? 4 namepsaces? How does that matter?

> In the current case we have four CQs per core and
> in the shared case we have a single CQ per core.

This makes me think that the host connected to 4 controllers...

> Until 14 cores there is no
> significant change in performance and the number of interrupts per second
> is less than a million in the current case.

This is interesting, what changes between different cores? I'm assuming
that a single core with 4 CQs vs. 1 CQ would have shown the difference
no?

> ==================================================
> |Cores|Current KIOPs  |Shared KIOPs  |improvement|
> |-----|---------------|--------------|-----------|
> |14   |2188           |2620          |19.7%      |
> |-----|---------------|--------------|-----------|
> |20   |2063           |2308          |11.8%      |
> |-----|---------------|--------------|-----------|
> |28   |1933           |2235          |15.6%      |
> |=================================================
> |Cores|Current avg lat|Shared avg lat|improvement|
> |-----|---------------|--------------|-----------|
> |14   |817us          |683us         |16.4%      |
> |-----|---------------|--------------|-----------|
> |20   |1239us         |1108us        |10.6%      |
> |-----|---------------|--------------|-----------|
> |28   |1852us         |1601us        |13.5%      |
> ========================================================
> |Cores|Current interrupts|Shared interrupts|improvement|
> |-----|------------------|-----------------|-----------|
> |14   |2131K/sec         |425K/sec         |80%        |
> |-----|------------------|-----------------|-----------|
> |20   |2267K/sec         |594K/sec         |73.8%      |
> |-----|------------------|-----------------|-----------|
> |28   |2370K/sec         |1057K/sec        |55.3%      |
> ====================================================================
> |Cores|Current 99.99th PCTL lat|Shared 99.99th PCTL lat|improvement|
> |-----|------------------------|-----------------------|-----------|
> |14   |85Kus                   |9Kus                   |88%        |
> |-----|------------------------|-----------------------|-----------|
> |20   |6Kus                    |5.3Kus                 |14.6%      |
> |-----|------------------------|-----------------------|-----------|
> |28   |11.6Kus                 |9.5Kus                 |18%        |
> |===================================================================
> 
> Performance improvement with 16 disks (16 CQs per core) is comparable.
> What we can see is that once we reach a couple million interrupts per
> second the Intel CPU can no longer sustain line rate and this feature
> mitigates that effect.

I'm not sure I understand what is the global effect here.
