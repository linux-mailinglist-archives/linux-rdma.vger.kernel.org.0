Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6466724132
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfETT24 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 15:28:56 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10549 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfETT24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 15:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558380534; x=1589916534;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bKNayrA+G6fJE55nf/RGVeQLFTgmu9sC6p09mCjURd8=;
  b=mvj0SGW9fNn7ZFW0xlHAyLLZzUY9tBklgVIqeIf8rDt7oeT59rA/uVny
   XvQeD3ZmNXxY8U2LtlarhLxOKXBUkqwl3rfhd9n1iQXBh0xAjAYIdth4n
   hmVCLhqtphgTLZU6pTFIPefoTjaaasBOyokF16c5NTiQdF+xyMaqoCJgl
   E=;
X-IronPort-AV: E=Sophos;i="5.60,492,1549929600"; 
   d="scan'208";a="800639166"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 May 2019 19:28:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4KJSowY033979
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 20 May 2019 19:28:52 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 May 2019 19:28:52 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.34) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 May 2019 19:28:44 +0000
Subject: Re: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        "Steve Wise" <swise@opengridcomputing.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-5-leon@kernel.org>
 <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
 <20190520190115.GC26206@mellanox.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <f89e1ef7-ecce-7c53-efd8-f7b9b27405f6@amazon.com>
Date:   Mon, 20 May 2019 22:28:33 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520190115.GC26206@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D12UWA004.ant.amazon.com (10.43.160.168) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/05/2019 22:01, Jason Gunthorpe wrote:
> On Mon, May 20, 2019 at 03:39:26PM +0300, Gal Pressman wrote:
>> On 20/05/2019 9:54, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@mellanox.com>
>>>
>>> There are two possible execution contexts of destroy flows in EFA.
>>> One is normal flow where user explicitly asked for object release
>>> and another error unwinding.
>>>
>>> In normal scenario, RDMA/core will ensure that udata is supplied
>>> according to KABI contract, for now it means no udata at all.
>>>
>>> In unwind flow, the EFA driver will receive uncleared udata from
>>> numerous *_create_*() calls, but won't release those resources
>>> due to extra checks.
>>
>> Thanks for the fix Leon, a few questions:
>>
>> Some of the unwind flows pass NULL udata and others an uncleared udata (is it
>> really uncleared or is it actually the create udata?), what are we considering
>> as the expected behavior? Isn't passing an uncleared udata the bug here?
> 
> Passing a NULL udata to destroy a user object would be a core code
> bug.

OK, there are at least two occurrences of this (create_qp and create_cq error
flows) that should be fixed.

> 
> But, I thought we fixed the error case flows that were sending in
> uninited udata already? It is not null, but it is initialized and
> 'empty'

We fixed the cases where calls to destroy would pass uninitialized udata, this
doesn't cover the create_* error flows that call destroy, which is a bug IMO.
