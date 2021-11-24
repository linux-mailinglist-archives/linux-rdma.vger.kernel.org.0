Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73D645C78C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 15:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355984AbhKXOii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 09:38:38 -0500
Received: from out2.migadu.com ([188.165.223.204]:59404 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351722AbhKXOid (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Nov 2021 09:38:33 -0500
Message-ID: <407c2dcf-67dd-3fd6-e01f-6006fcf97986@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1637764522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHKrIHQTt5Q8Xfp8OnpxxJ88zbPqKG4bNXeSpoP2TfM=;
        b=lbigi5MCjDl87/1xWdF3OkK1eA5lbxNAkVJgSbZu7tg/vUtYcqWPGFmbOssQxKlMaUSWY3
        c6u9cEcWoJvb03mAfv2UsofBf7EPXdjafestdyLzMuLCawCkmpt2LfdDNFWbTKH5cnD+jI
        LRmhT8d5cv2cJkUomAHDZUFyL56uCMk=
Date:   Wed, 24 Nov 2021 22:35:14 +0800
MIME-Version: 1.0
Subject: Re: Two announcements
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <CAGbH50sEwKeB3bH6XHm+C1R_giN85pi6Bqq4fk-rFq-iU3bavg@mail.gmail.com>
 <YZoJrPGtQJ9e3v9K@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YZoJrPGtQJ9e3v9K@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2021/11/21 16:56, Leon Romanovsky 写道:
> On Thu, Nov 18, 2021 at 02:57:09PM -0600, Doug Ledford wrote:
>> First, many of us have talked in the past about the benefit dedicated
> 
> <...>
> 
> Thank you Doug for your dedicated work all these years.
+1. Thanks Doug

Zhu Yanjun
> 
>>
>> -- 
>> Doug Ledford <dledford@redhat.com>
>> GPG KeyID: B826A3330E572FDD
>> Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
>>

