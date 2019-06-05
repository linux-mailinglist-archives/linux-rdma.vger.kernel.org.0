Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E73362D5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfFERiF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:38:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46762 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFERiF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:38:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so1474658ote.13
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eBoXLA9ZsigJJ81HDdNTeRsJDjplz1v5XESHKmrGXyE=;
        b=JvjQrE7JgmiASu2aDgWOA1HhlSiw7qdzXkBpkQu7yASECQ6B34tZTmBR4YysDx5lQv
         4TQXiXv9eBeHDMNB6hUZgYgUZ9nPP0fC0xx7EZ6CvT7H0CjdPYPKfDNAv+ZD8WjoBMnN
         FrZg1YC6P2VbSdMs6yF5ZicOcFcfy7U4FgAorYWRWyvGV6Txycn3zZd6lO0o2p2VygF+
         3b2k4VBeg758kBpiZLycIjQYjRwwkWbH8vgFElCXkca29y1+22Rhx8ZNsBHd/dWbv35W
         5iArIW+TeX1bCJmraYxvY9OPnBdiOLoy9Qcl+c4qfNVtVVn8O5e3FkgZNf4gKpli7yqn
         DjFw==
X-Gm-Message-State: APjAAAXiSEVzCeTa8QRF7Olnvm3+MLtLOpN3DZzI/ZC1PQVNpKKcsC3/
        yHg5UYIPILgP8Nzut4C7mww=
X-Google-Smtp-Source: APXvYqxtGoLaT3gB6ox/UWzAURnvgLk+SXCPykZ08ZY84SZY8bjpF7CJZkBMfS3tyjFZPudlXnE6sA==
X-Received: by 2002:a9d:be9:: with SMTP id 96mr10131214oth.49.1559756284921;
        Wed, 05 Jun 2019 10:38:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id j204sm7762783oif.37.2019.06.05.10.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:38:04 -0700 (PDT)
Subject: Re: [PATCH 04/20] RDMA/core: Introduce ib_map_mr_sg_pi to map
 data/protection sgl's
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-5-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b9c0f67c-e690-b6db-b326-2c76cfcab7b9@grimberg.me>
Date:   Wed, 5 Jun 2019 10:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-5-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> +/**
> + * ib_map_mr_sg_pi() - Map the dma mapped SG lists for PI (protection
> + *     information) and set an appropriate memory region for registration.
> + * @mr:             memory region
> + * @data_sg:        dma mapped scatterlist for data
> + * @data_sg_nents:  number of entries in data_sg
> + * @data_sg_offset: offset in bytes into data_sg
> + * @meta_sg:        dma mapped scatterlist for metadata
> + * @meta_sg_nents:  number of entries in meta_sg
> + * @meta_sg_offset: offset in bytes into meta_sg
> + * @page_size:      page vector desired page size
> + *
> + * Constraints:
> + * - The MR must be allocated with type IB_MR_TYPE_INTEGRITY.
> + *
> + * Returns the number of sg elements that were mapped to the memory region.

Question, is it possible that all data sges were mapped but not all
meta sges? Given that there is a non-trivial accounting on the relations
between data and meta sges maybe the return value should be
success/failure?

Or, if this cannot happen we need to describe why here.
