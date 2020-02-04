Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF8151CC4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 16:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgBDPAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 10:00:09 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:20576 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgBDPAJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 10:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580828408; x=1612364408;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KA4yBFgPijpjl8iHouSz2wSOQveu4r3M6VwWaHth7Ts=;
  b=FgwUWXoAgAGkcsriUhF8bXxlersTURtoSseuIImRtL298/lzVlfIwT1n
   M/ICR2/OUq5Cx88Tjhy82hkxVzmx1/Z/eIsO5FoaPbYqOCc/u3lW7yu6q
   U/cpLu2jsxqGzijEI+fADIwgHANNYRynLU21oqF/VoASajR6b7PQtGxH4
   g=;
IronPort-SDR: IhW4ca7rHd7qBjw913yXQd1K/eeoSupE5TJzYWKoYaFlu2Gq/Xd+5XUDPZ2wk2CwGsluYlpQk8
 2QrqmXyHbdzQ==
X-IronPort-AV: E=Sophos;i="5.70,402,1574121600"; 
   d="scan'208";a="14563684"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 04 Feb 2020 14:59:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id BA193A06CC;
        Tue,  4 Feb 2020 14:59:56 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 4 Feb 2020 14:59:56 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.45) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 4 Feb 2020 14:59:52 +0000
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
To:     Honggang LI <honli@redhat.com>,
        "Goldman, Adam" <adam.goldman@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <mike.marciniszyn@intel.com>,
        <dennis.dalessandro@intel.com>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200204141440.GA1062279@dhcp-128-72.nay.redhat.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <984452af-7c41-cad0-be9c-ed74d269b89d@amazon.com>
Date:   Tue, 4 Feb 2020 16:59:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204141440.GA1062279@dhcp-128-72.nay.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.45]
X-ClientProxiedBy: EX13D32UWB003.ant.amazon.com (10.43.161.220) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/02/2020 16:14, Honggang LI wrote:
>> +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"
> 
> Maybe, we should not enable device rename as default for all RDMA
> hardware. Leave it to system admin to apply rename or not.
> 
> We are observing issues with RDMA device renaming too.

+1, we're experiencing similar issues as well.
If not disabling by default, we need an easy way to disable the feature.
