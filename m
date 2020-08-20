Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309D524AF8D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgHTHGp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 03:06:45 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43963 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgHTHGo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 03:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597907205; x=1629443205;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=vw5BP+NpTujkZJrgnp9hacv7aJVac9aU5pRSCq2ulIs=;
  b=IpbZrBBspzaMt2kA/jSjBdODOnnbWeLovvW5v4Z58JitcrtBCag9m/eQ
   QMI9j7YtVGSlSYUwmN+WEPI7U95kJ1z1G5cdMhNwzLGXPPKn4hhLKThCy
   U8L46BJHeWLVCdB9k60O3du9jwAw4hucuukraeR1iP1viQdfOngBXxdr+
   U=;
X-IronPort-AV: E=Sophos;i="5.76,332,1592870400"; 
   d="scan'208";a="68178057"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Aug 2020 07:06:40 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 0C6C7A21AE;
        Thu, 20 Aug 2020 07:06:39 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:06:39 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.38) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:06:37 +0000
Subject: Re: CFP for RDMA minisummit at virtual LPC 2020
To:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20200623182051.GD184720@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <3c9d4ba8-1648-235e-01a9-cd29884aaf59@amazon.com>
Date:   Thu, 20 Aug 2020 10:06:32 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200623182051.GD184720@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D36UWB001.ant.amazon.com (10.43.161.84) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 23/06/2020 21:20, Leon Romanovsky wrote:
> Hi,
> 
> I will be short.
> 
> Please send me/Jason/Doug/"mailing list" the topics which you would
> like to discuss at RDMA minisummit at LPC 2020 which will be virtual
> this year.
> 
> Thanks
> 

Is the RDMA MC happening this year?
