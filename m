Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693EE47F9D6
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Dec 2021 04:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhL0DL1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Dec 2021 22:11:27 -0500
Received: from out1.migadu.com ([91.121.223.63]:62580 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234812AbhL0DL1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Dec 2021 22:11:27 -0500
Subject: Re: [PATCH for-next 0/7] RTRS renaming
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640574685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yC429pRHs6p792jN4frsge8Z8bVpSluoXV73ZdUWsU8=;
        b=WlsNNMHoA4Aa/S30ffKUa80D7SMHJXk8lRUZb9EJI7Xbjy5r16hG9OC/NAQSxNwFjI+slh
        MzH1LSK0CCtrULAF28wvRl9Mn8x5FKt2jufyhgOwFCXLyXbwbgQV5mAiJjwuNLqoHTTpyG
        wYUd9K/GZpWKPRytTF8oq06uep7jgmI=
To:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com
References: <20211223104229.23053-1-jinpu.wang@ionos.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <aac5544b-279d-35f5-6f19-eb0301294122@linux.dev>
Date:   Mon, 27 Dec 2021 11:11:20 +0800
MIME-Version: 1.0
In-Reply-To: <20211223104229.23053-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jack,

On 12/23/21 6:42 PM, Jack Wang wrote:
>    RDMA/rtrs: Rename rtrs_sess to rtrs_path
>    RDMA/rtrs-srv: Rename rtrs_sess to rtrs_path
>    RDMA/rtrs-clt: Rename rtrs_sess to rtrs_path

I guess you need to fold all the changes which rename rtrs_see to 
rtrs_path into
one patch to make series bisectable.

Thanks,
Guoqing

