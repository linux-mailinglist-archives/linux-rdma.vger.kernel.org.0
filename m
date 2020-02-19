Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D95164C45
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 18:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSRlz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 12:41:55 -0500
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:32778
        "EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgBSRlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 12:41:55 -0500
Received: from [192.168.0.78] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id 4TM9j6pqadKMb4TM9jf8Kv; Wed, 19 Feb 2020 10:41:54 -0700
X-CMAE-Analysis: v=2.3 cv=VfKJw2h9 c=1 sm=1 tr=0
 a=ugQcCzLIhEHbLaAUV45L0A==:117 a=ugQcCzLIhEHbLaAUV45L0A==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=e4k_Uep51z5miWk8QScA:9
 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
To:     Jason Gunthorpe <jgg@ziepe.ca>, Mark Zhang <markz@mellanox.com>
Cc:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
 <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
 <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
 <55e8c9cf-cd64-27b2-1333-ac4849f5e3ff@talpey.com>
 <e758da0d-94a3-a22f-c2aa-3d13714c4ed3@talpey.com>
 <4fc5590f-727c-2395-7de0-afb1d83f546b@mellanox.com>
 <91155305-10f0-22b5-b93b-2953c53dfc46@talpey.com>
 <cb5ab63b-57cd-46ac-0d51-8bffaf537590@mellanox.com>
 <20200219130613.GM31668@ziepe.ca>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a0067ba5-c15b-4194-0de2-3964393e9993@talpey.com>
Date:   Wed, 19 Feb 2020 12:41:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219130613.GM31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNdKGI+1+gafTmxopzH3FTwVnPNcca3jCiQhtwgu1hieTPEgQMnQXn8Lps5P3WYTrY1vLoE0dbDKK0vM2Mt897OdSuMZbnYRSy61Qi9y05aQvmSY7eCi
 6kSHN1Ty5HdyMqRQem9AuvsiIPYHmZpbpKG8PRviAjBCYAlgS0Zb18i4T9a2/4KcbtayC51nb/ZNcAr/IVbFRc0uDf/lQdOGdOLwoK62DYMq4BrYvGMgpK1B
 2sie/k75OGw/c/y4zwLJ13kjTQLKbM4NoOE4K+09beaaXdNG3vVePkbGtX++h4T/+I/6dcndRCSXotrbUMG1qZirr1p0En99hqvwqEEYs+Lbhql+85nOGD5a
 7Q30+sqzRQ6x1to9dGgzCRIaA4w29SPnbjheaIsdeHEUiQ5EpRSjnYKrqbsfibX7T2KTgb35
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/19/2020 8:06 AM, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2020 at 02:06:28AM +0000, Mark Zhang wrote:
>   
>> The symmetry is important when calculate flow_label with DstQPn/SrcQPn
>> for non-RDMA CM Service ID (check the first mail), so that the server
>> and client will have same flow_label and udp_sport. But looks like it is
>> not important in this case.
> 
> If the application needs a certain flow label it should not rely on
> auto-generation, IMHO.
> 
> I expect most networks will not be reversible anyhow, even with the
> same flow label?

These are network flow labels, not under application control. If they
are under application control, that's a security issue.

But I agree, if the symmetric behavior is not needed, it should be
ignored and a better (more uniformly distributed) hash should be chosen.

I definitely like the simplicity and perfect flatness of the newly
proposed (src * 31) + dst. But that "31" causes overflow into bit 21,
doesn't it? (31 * 0xffff == 0x1f0000)

Tom.
