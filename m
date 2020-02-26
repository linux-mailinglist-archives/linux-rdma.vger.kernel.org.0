Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE77170C3F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 00:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBZXGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 18:06:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42135 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgBZXGC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 18:06:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so1106307otd.9
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 15:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rz8owZz048vr1Nb1eXiJd5TZUtHPUckitGOYNGK22uE=;
        b=ZglgLIS2XH93GhjAlrZtubmMxngtPvbE2ShHL+DJJXQPIxSccTkaTN/31KG+d/iWI9
         2bPeglpoE8EpkovZWUeH8sH5U5b9eVnnZagGbCXufeChAloCF2yKTLGiky+UbPktikAt
         hZl8VXxZsEUygcSsJ5VSqIoeyFPC7qtqDz3lnbpawbyWJLFD84SvCs8/4Fi0qsz9KzQ1
         Ea2meQLz3f0Ly37yI7QXpT9/n8H2wl9cwnnruHoh2PZp58eETTIX7QZSR/QG1f5cOG/w
         yRvK+EuFH9jxss/BXQB6YKYq4g9v/hK5eNkEpbgifYdc6SIcsJgIqnYK437Ld/Z0W6FB
         AAbw==
X-Gm-Message-State: APjAAAV4Y4G06f3r39y84Foe4XzMaLI1e6ghwBUQXxomSiUtHEIvoMQe
        +3JfK/G/9lJsDFkMI1Z4fPT1xQ5J
X-Google-Smtp-Source: APXvYqwTl7SOLrFBI6vzf2RPwJP474QUd6yAAHJIHaciF3OeoD/yWAYlxR4HJV/lHgqjIC4XHy9FjA==
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr939317oto.171.1582758362095;
        Wed, 26 Feb 2020 15:06:02 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 5sm1298377otr.13.2020.02.26.15.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:06:01 -0800 (PST)
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-nvme@lists.infradead.org, hch@lst.de
Cc:     linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
References: <20200226141318.28519-1-krishna2@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
Date:   Wed, 26 Feb 2020 15:05:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226141318.28519-1-krishna2@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Current nvmet-rdma code allocates MR pool budget based on host's SQ
> size, assuming both host and target use the same "max_pages_per_mr"
> count. But if host's max_pages_per_mr is greater than target's, then
> target can run out of MRs while processing larger IO WRITEs.
> 
> That is, say host's SQ size is 100, then the MR pool budget allocated
> currently at target will also be 100 MRs. But 100 IO WRITE Requests
> with 256 sg_count(IO size above 1MB) require 200 MRs when target's
> "max_pages_per_mr" is 128.

The patch doesn't say if this is an actual bug you are seeing or
theoretical.

> The proposed patch enables host to advertise the max_fr_pages(via
> nvme_rdma_cm_req) such that target can allocate that many number of
> RW ctxs(if host's max_fr_pages is higher than target's).

As mentioned by Jason, this s a non-compatible change, if you want to
introduce this you need to go through the standard and update the
cm private_data layout (would mean that the fmt needs to increment as
well to be backward compatible).


As a stop-gap, nvmet needs to limit the controller mdts to how much
it can allocate based on the HCA capabilities
(max_fast_reg_page_list_len).
