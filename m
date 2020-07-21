Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3B227ECA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGUL1M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 07:27:12 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13607 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGUL1M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 07:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595330832; x=1626866832;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=So9ctermII+g6xlrDJ0EGP5lQZ20ONDcLN7hfkRlRzM=;
  b=HGOFEyzaGjpTz0800ZxHS8HeYyI2JOOdYRVGPGjFl/SmPi4O8PTPU26L
   AO1bUX1/0o+mRbPfbjJ291N4K8weYk9f2cx37k5SL4xYM0ewnNQWYUzzA
   pc8ql7vWsDnc30kP5mwBmiVcuSqOJneGhMYAptD1MUwY6SMnGk9oqs48e
   A=;
IronPort-SDR: lOdakeJDFiW5kkJuHoyUMwZo5Buvus52rNF40CDvqQiXRXUK613mhFhZueSQlB9a5zlVg/WmV7
 YqmwHV0Qcxhw==
X-IronPort-AV: E=Sophos;i="5.75,378,1589241600"; 
   d="scan'208";a="60304178"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 21 Jul 2020 11:27:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 42A15A1C0E;
        Tue, 21 Jul 2020 11:27:05 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 11:27:05 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.73) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Jul 2020 11:27:00 +0000
Subject: Re: [PATCH for-next v2 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
To:     kernel test robot <lkp@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        "Shadi Ammouri" <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200720080113.13055-4-galpress@amazon.com>
 <202007210118.fF0Xv5Jy%lkp@intel.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <99314564-cb73-5a25-3583-1afda323d2b3@amazon.com>
Date:   Tue, 21 Jul 2020 14:26:55 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007210118.fF0Xv5Jy%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D11UWB001.ant.amazon.com (10.43.161.53) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/07/2020 20:08, kernel test robot wrote:
> Hi Gal,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on 5f0b2a6093a4d9aab093964c65083fe801ef1e58]
> 
> url:    https://github.com/0day-ci/linux/commits/Gal-Pressman/Add-support-for-0xefa1-device/20200720-160419
> base:    5f0b2a6093a4d9aab093964c65083fe801ef1e58
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cf1105069648446d58adfb7a6cc590013d6886ba)

Uh, looks like I use some gcc specific stuff here.. I guess it's time to start
checking clang compilation as well :).

Will fix and resubmit.
