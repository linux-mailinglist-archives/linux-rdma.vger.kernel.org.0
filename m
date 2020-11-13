Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4322B1FCD
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKMQM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 11:12:58 -0500
Received: from bosmailout10.eigbox.net ([66.96.185.10]:39815 "EHLO
        bosmailout10.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgKMQM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 11:12:57 -0500
Received: from bosmailscan10.eigbox.net ([10.20.15.10])
        by bosmailout10.eigbox.net with esmtp (Exim)
        id 1kdbh1-0005Q2-JI; Fri, 13 Nov 2020 11:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cornelisnetworks.com; s=dkim; h=Sender:Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I7K6O43ihGGOH28+RqFfcTYQnUcAUwFpAo/tpNQRB1g=; b=PkvC2FWBWCFsG7biYAV/OIaj7a
        Cq1tqkkCcknF+YWzuoctEBwuCR6lCfAPZH7BdOORfK86wpDN3TmPoim6J6yFZhf3y52KRQseHWKIS
        mYF3NYy+sehMCMNNc04gLUp9by0h7dB0izPMzGU9p85pEk5VWVEHZluspNNozwhE8uI3OvrztqwHj
        BT1knDzaovRQJweUtcvAvIhkJI1lVGwRMJlDXT6XkxrS+9CGyBi6M767ViaEPZZPW/SAa8KHfzH0Q
        xV+neEe0AG6zrZ8lQjDiQ5PGRrYyB6GxfaKGG9HS6wIQcPJmSahk1HSeukwXqTdR03vYaZ+jOpamV
        AsZb+Zuw==;
Received: from [10.115.3.31] (helo=bosimpout11)
        by bosmailscan10.eigbox.net with esmtp (Exim)
        id 1kdbh1-00033P-9y; Fri, 13 Nov 2020 11:12:55 -0500
Received: from bosauthsmtp14.yourhostingaccount.com ([10.20.18.14])
        by bosimpout11 with 
        id rsCs2300A0JCtq201sCvAP; Fri, 13 Nov 2020 11:12:55 -0500
X-Authority-Analysis: v=2.3 cv=DtjNBF3+ c=1 sm=1 tr=0
 a=AnsiuLKgxXFeB68GILQVjQ==:117 a=PId9yTw908ogKca1p5g/DQ==:17
 a=IkcTkHD0fZMA:10 a=nNwsprhYR40A:10 a=V1zYLna590sA:10 a=i0EeH86SAAAA:8
 a=LRYjQimtAAAA:8 a=iuss-EWV1xAoJR7U0UoA:9 a=QEXdDO2ut3YA:10
 a=JC7xiqAVgOyvJ6DxgMma:22
Received: from [192.55.54.42] (port=40911)
        by bosauthsmtp14.eigbox.net with esmtpa (Exim)
        id 1kdbgy-00009w-3I; Fri, 13 Nov 2020 11:12:52 -0500
Subject: Re: [PATCH] IB/hfi1: fix error return code in hfi1_init_dd()
To:     Zhang Changzhong <zhangchangzhong@huawei.com>,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, sadanand.warrier@intel.com,
        grzegorz.andrejczuk@intel.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1605249747-17942-1-git-send-email-zhangchangzhong@huawei.com>
From:   Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Message-ID: <c0a3d9c7-362f-0415-ee3e-c5e3a975d9c6@cornelisnetworks.com>
Date:   Fri, 13 Nov 2020 11:12:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1605249747-17942-1-git-send-email-zhangchangzhong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EN-UserInfo: 0c01d0184442a6165e428d14bd4242e2:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: mike.marciniszyn@cornelisnetworks.com
Sender:  Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
X-EN-OrigIP: 192.55.54.42
X-EN-OrigHost: unknown
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/13/2020 1:42 AM, Zhang Changzhong wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

We actually have this exact patch queued but have not yet sent it.

You saved us the trouble!

Mike

Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
