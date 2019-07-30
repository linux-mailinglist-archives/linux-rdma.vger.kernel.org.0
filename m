Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBB77A820
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfG3MVo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 08:21:44 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:5568 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfG3MVo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 08:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564489303; x=1596025303;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+3Q5VpmhbDqh98hk88+++THcMGfXmhtrDwu+J6O7DCs=;
  b=GijaIfnilKw3eQkR3GU9eo7z4QY4B2ncLvBvO0LpmZvVthglhsKEd0NQ
   WEps/Ak+muyxXZwKUNXoxCg1CPaxZQGXTTL5yIj4d45nzjD8yUHrzoWUs
   sO3oVn399kp8DTsYUIRVqRoSlt80R4ufRitDu2IImi5qC19H8RG9C2iWK
   0=;
X-IronPort-AV: E=Sophos;i="5.64,326,1559520000"; 
   d="scan'208";a="407247149"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 30 Jul 2019 12:21:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 0B585A27F8;
        Tue, 30 Jul 2019 12:21:40 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 12:21:40 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.191) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 12:21:36 +0000
Subject: Re: [PATCH for-rc] RDMA/restrack: Track driver QP types in resource
 tracker
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190730110137.37826-1-galpress@amazon.com>
 <20190730121909.GB13921@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <7a7950b4-21f1-dfcc-2d8a-6d49ed81e7d0@amazon.com>
Date:   Tue, 30 Jul 2019 15:21:31 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730121909.GB13921@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.191]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/07/2019 15:19, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2019 at 02:01:37PM +0300, Gal Pressman wrote:
>> The check for QP type different than XRC has wrongly excluded driver QP
>> types from the resource tracker.
> 
> -rc commit messages need to describe the problem this is fixing from
> the users perspective.

Thanks, will resubmit.
