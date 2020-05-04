Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550651C37A2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgEDLEe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 07:04:34 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:52245 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgEDLEd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 07:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588590273; x=1620126273;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=msaw/dV+l3ilNIq2gAhEIAGld6Ei0x9Cyd4DxZzJMLM=;
  b=ez7hJpdz2GzHeDRM8sd3Lkwkr/bn1buKXhakFOMgX9xPYxMSTejOv74b
   6YyRZfdXcLsGsO7dzcYR7UN9nsWhxRShke7f4N1LEtYaCPqDUtvqXPF5C
   0CZcrWRWdlo2EmJiCgsemFMaRId5m3xqySBO3SJSQm6EhJKar8p1rFYcT
   Y=;
IronPort-SDR: MqLK5KSJe2Rex1ICkQfK7Ft3To415uzZbQakxxcsmwBwm1rm8sq0E2e9qyUUb+ajK9h0WuU3Zi
 LQgeZ61XyWDg==
X-IronPort-AV: E=Sophos;i="5.73,351,1583193600"; 
   d="scan'208";a="28485020"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 04 May 2020 11:04:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 248F0A07FF;
        Mon,  4 May 2020 11:04:18 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 11:04:17 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.34) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 11:04:13 +0000
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Add support for drop action in DV
 steering
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daria Velikovsky <daria@mellanox.com>,
        <linux-rdma@vger.kernel.org>, "Maor Gottlieb" <maorg@mellanox.com>
References: <20200504054227.271486-1-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3d2f79f8-bee5-6620-8f46-6f718c619dba@amazon.com>
Date:   Mon, 4 May 2020 14:04:07 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504054227.271486-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D30UWB004.ant.amazon.com (10.43.161.51) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/05/2020 8:42, Leon Romanovsky wrote:
> From: Daria Velikovsky <daria@mellanox.com>
> 
> When drop action is used the matching packet will stop
> processing in steering and will be dropped. This functionality
> will allow users to drop matching packets.
> .

An extra dot slipped in.

> Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
