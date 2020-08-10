Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206EB240741
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHJOK7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 10:10:59 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37602 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgHJOK6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Aug 2020 10:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597068658; x=1628604658;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=K2NJsOAM5sI5gHoNiB5JbWPfJXzu9a95v/fFZtCpfTc=;
  b=X1HKSDSiifUJC6guphsAp3y1XRg8zPR7s1LimysWZo8lpzXC/fYfJj+1
   Bjv/o7ALjIM2XPGzAe6FmD5UULC9GCSEkPBqYnEZXXMYyfbKRJeXThy+Q
   5V9maH56etiGbA3x5p19jJD8AMF781hXffqIdTe4PaoDnQYFNGJ+SQnnA
   0=;
IronPort-SDR: C3Kc7QcAkS9j3B6AoM9I2GMOhSDnZPlOCr80Fn017PrwqvQnkXs8QRdlELInlN5GQf/YUQ87gx
 ZkbV1sy2Yr4w==
X-IronPort-AV: E=Sophos;i="5.75,457,1589241600"; 
   d="scan'208";a="58669976"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Aug 2020 14:10:56 +0000
Received: from EX13MTAUEB002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 6910EA1E52;
        Mon, 10 Aug 2020 14:10:55 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEB002.ant.amazon.com (10.43.60.12) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 10 Aug 2020 14:10:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.145) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 10 Aug 2020 14:10:50 +0000
Subject: Re: [PATCH for-rc v2 0/6] Add CM packets missing and harden the
 proxying
To:     Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Jack Morgenstein" <jackm@dev.mellanox.co.il>, <ranro@mellanox.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
 <A84B2186-42F4-4164-B80D-27782CEAE925@oracle.com>
 <20200810114637.GA20478@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <b31db3dc-437c-a61f-815c-418cf436861f@amazon.com>
Date:   Mon, 10 Aug 2020 17:10:44 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810114637.GA20478@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D48UWB002.ant.amazon.com (10.43.163.125) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/08/2020 14:46, Leon Romanovsky wrote:
> On Mon, Aug 10, 2020 at 01:20:43PM +0200, Håkon Bugge wrote:
>> A friendly reminder.
> 
> We are in merge window.

The merge window shouldn't affect bug fixes submissions, no?
