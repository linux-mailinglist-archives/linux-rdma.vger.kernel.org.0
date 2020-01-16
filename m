Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0381513D62D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 09:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgAPIwF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 03:52:05 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55343 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbgAPIwE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 03:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579164724; x=1610700724;
  h=subject:to:references:from:cc:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kXvgupyXLykpRb58yM1jqfwa0aRmdZUuPG6SD6Fmw7c=;
  b=kfyWkGFTjSSj2gGF0XRtRqAoosf9LfHSu65lXMjs/lePJejkks+Je50g
   UBNobnlVoZw3dbbRT/1Mm7cAGAZU9fsPUu1DmvuEB2eb27E7OGLadkfZQ
   MbvMRsUW1esl6ZNi7EJl+3D8GOyAWC8jxBkSD0JZ4gVR3ywQVUDmNfpup
   E=;
IronPort-SDR: sfQm9bd0VTnjVqfla/0EdoaKvmIgUttmk3mqPGXVVEdplqnltlBF71mx6lOxxrxyjiUM7GaFGf
 b4Qo2d/s5MOw==
X-IronPort-AV: E=Sophos;i="5.70,325,1574121600"; 
   d="scan'208";a="12620272"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 16 Jan 2020 08:52:02 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 5A0CFA223A;
        Thu, 16 Jan 2020 08:52:01 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 16 Jan 2020 08:52:00 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.48) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 16 Jan 2020 08:51:57 +0000
Subject: Re: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is a
 fence
To:     Jason Gunthorpe <jgg@mellanox.com>
References: <20200115202041.GA17199@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>
Message-ID: <558b9eac-ce28-a0b7-9830-5416d0a0f7ca@amazon.com>
Date:   Thu, 16 Jan 2020 10:51:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115202041.GA17199@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D04UWB003.ant.amazon.com (10.43.161.231) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 15/01/2020 22:20, Jason Gunthorpe wrote:
> The set of entry->driver_removed is missing locking, protect it with
> xa_lock() which is held by the only reader.
> 
> Otherwise readers may continue to see driver_removed = false after
> rdma_user_mmap_entry_remove() returns and may continue to try and
> establish new mmaps.

That's kind of an inherent race regardless, isn't it?

LGTM,
Reviewed-by: Gal Pressman <galpress@amazon.com>
