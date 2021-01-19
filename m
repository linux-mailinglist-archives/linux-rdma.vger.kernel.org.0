Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A82B2FB2BC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 08:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhASHS6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 02:18:58 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:26099 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbhASHS3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 02:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611040710; x=1642576710;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+JzX/lnJ4B5mRPlvcGIoP2Ln2iA0CUb1UhBnM36P/EM=;
  b=Hc3rEnX4/od/EB34vVUoOxmsygAeNPYtNY75bYyazEIiY2tMzZOpQbKQ
   egoo9evHSKeYgdA6Ltp28QGgapoo3sdU5aCYSv6fGZSIblI5A7yFwz2ec
   KG+q7p0jqtHNQAj5rYgoQYkH8x+mOBtGajfacNwIknJHWDSnaZoqWUXT+
   E=;
X-IronPort-AV: E=Sophos;i="5.79,358,1602547200"; 
   d="scan'208";a="75753295"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 19 Jan 2021 07:17:25 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 546CC240D53;
        Tue, 19 Jan 2021 07:17:23 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.252) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 Jan 2021 07:17:19 +0000
Subject: Re: [PATCH for-next 0/2] Host information userspace version
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>
References: <20210105104326.67895-1-galpress@amazon.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9286e969-09b8-a7d0-ca7e-50b8e3864a11@amazon.com>
Date:   Tue, 19 Jan 2021 09:17:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210105104326.67895-1-galpress@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.252]
X-ClientProxiedBy: EX13D34UWA001.ant.amazon.com (10.43.160.173) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/01/2021 12:43, Gal Pressman wrote:
> The following two patches add the userspace version to the host
> information struct reported to the device, used for debugging and
> troubleshooting purposes.
> 
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/918
> 
> Thanks,
> Gal

Anything stopping this series from being merged?
