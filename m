Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294E8FD6D2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 08:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfKOHSJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Nov 2019 02:18:09 -0500
Received: from 7.mo176.mail-out.ovh.net ([46.105.53.191]:36614 "EHLO
        7.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKOHSJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Nov 2019 02:18:09 -0500
X-Greylist: delayed 1197 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2019 02:18:08 EST
Received: from ex2.mail.ovh.net (unknown [10.109.143.58])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 6DABD175589;
        Fri, 15 Nov 2019 07:41:04 +0100 (CET)
Received: from [10.0.2.127] (90.114.93.0) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 15
 Nov 2019 07:41:03 +0100
Subject: =?UTF-8?B?UmU6IOOAkHF1ZXN0aW9u44CR?=
To:     oulijun <oulijun@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <8bc6ad1f-075a-e4d4-e5ac-c14de41c4a47@huawei.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <d006cbf9-cbf6-3958-0a83-4d474f6e16d6@morey-chaisemartin.com>
Date:   Fri, 15 Nov 2019 07:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8bc6ad1f-075a-e4d4-e5ac-c14de41c4a47@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [90.114.93.0]
X-ClientProxiedBy: CAS10.indiv2.local (172.16.1.10) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 5224175568707315520
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefgedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgihesthejredttdefjeenucfhrhhomheppfhitgholhgrshcuofhorhgvhidqvehhrghishgvmhgrrhhtihhnuceonhhitgholhgrshesmhhorhgvhidqtghhrghishgvmhgrrhhtihhnrdgtohhmqeenucfkpheptddrtddrtddrtddpledtrdduudegrdelfedrtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepvgigvddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehnihgtohhlrghssehmohhrvgihqdgthhgrihhsvghmrghrthhinhdrtghomhdprhgtphhtthhopehouhhlihhjuhhnsehhuhgrfigvihdrtghomhenucevlhhushhtvghrufhiiigvpedt
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 11/15/19 3:48 AM, oulijun wrote:
> Hi, Nicolas Morey-Chaisemartin
>    I noticed that the rdma-core repository has a suse directory. What is he used for?

It contains the SUSE specific scripts and the spec file for the rdma-core RPM
> If I want to use the suse system directly, there is a user-mode driver for the rdma-core.Can he use it directly?

I'm not sure I understand what you are trying to do here.
rdma-core RPM should be available from SUSE repo on all recent distros.
For development purposes you could also build and use the upstream version. Easiest/cleanest way is probably to use cbuild to generate RPMs for you.

Nicolas
