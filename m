Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41107182B9C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 09:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgCLIzg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 04:55:36 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:50708 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgCLIzg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 04:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584003336; x=1615539336;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=J5koibo5VNijQJBAYaRROTOlxAxrbSMMybMA0inDjgY=;
  b=l9LKD9Klby3ekWiRMl1R8iGktHD/i5/I9JEVNjC4TD7Jh1esJlcTpIMI
   wziOmTxNrSPgEQM8csE5bmoAKnAkD84vYE/uQvL5vBWFyn7/63BMNg43S
   EUSxkht1iw7lYDWtQvawHZonzYqxw4q5Njrq20bkmgGwlran/lpoL/noc
   Y=;
IronPort-SDR: fcKY6T5eKAmZFcxMFfEbidRDTu/mfEuAiDKS3N9a8L1LqFrZOJp3EiAv6Cet2Xc+3pGJYwuTk/
 4ZdgVJhKFWwg==
X-IronPort-AV: E=Sophos;i="5.70,544,1574121600"; 
   d="scan'208";a="20905690"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Mar 2020 08:55:23 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id C921AA2471;
        Thu, 12 Mar 2020 08:55:21 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 12 Mar 2020 08:55:21 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 08:55:16 +0000
Subject: Re: [PATCH rdma-next] MAINTAINERS: Clean RXE section and add Zhu as
 RXE maintainer
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, "Moni Shoua" <monis@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
References: <20200312083658.29603-1-leon@kernel.org>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a8f279cf-6c33-5cda-9a04-e8fbffe1dea3@amazon.com>
Date:   Thu, 12 Mar 2020 10:55:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312083658.29603-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D24UWA002.ant.amazon.com (10.43.160.200) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/03/2020 10:36, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Zhu Yanjun contributed many patches to RXE and expressed genuine
> interest in improve RXE even more. Let's add him as a maintainer.

Did you mean let's make him the maintainer? You didn't add him, you replaced Moni.
