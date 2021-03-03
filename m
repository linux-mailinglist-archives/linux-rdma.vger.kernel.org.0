Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEA32C3C5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 01:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhCCX7n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Mar 2021 18:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234328AbhCCLmM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Mar 2021 06:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614771639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCfj/IdYiX5hh1kSfgYnluMWA7KXC90R6NsWIPre0IU=;
        b=HBVL+/OjAD9ZsoQhlnF/iBKnZ9qq4TH2HjAWkkyiv3AvEK7pZaPg9brt5FnSMCUCl/lJvn
        kn08pvUJfG1xfMy27xYLoHvTJ9bVvkTMs74cMe3HwrfZus7/Vddl7f3B9Er5/IX5H6uPEZ
        628JmPYJ7Hw6B2PCSCNwlRwT4bkLiU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-WaMgdSZ6MemmT9VJqrHiuQ-1; Wed, 03 Mar 2021 06:40:37 -0500
X-MC-Unique: WaMgdSZ6MemmT9VJqrHiuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C91DD107ACE3;
        Wed,  3 Mar 2021 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-197.pek2.redhat.com [10.72.12.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FD4660C5E;
        Wed,  3 Mar 2021 11:40:33 +0000 (UTC)
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
To:     Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
 <BYAPR04MB4965FDA9847096508E35FFB9869B9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <8b1fc0cd-196a-ad78-71c6-a7515ffbb4ad@redhat.com>
 <4d188158-3f18-c801-02ca-97350eb10c1b@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <70398f13-aefa-8de2-f6fe-bcfbfb20fcae@redhat.com>
Date:   Wed, 3 Mar 2021 19:40:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4d188158-3f18-c801-02ca-97350eb10c1b@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/2/21 11:59 AM, Bart Van Assche wrote:
> On 3/1/21 7:36 AM, Yi Zhang wrote:
>> This issue cannot be reproduced on latest 5.12.0-rc1.
>>
>> Please ignore this report, sorry for the noise.
> How about rerunning the same test against v5.11.2, the latest v5.11
> stable kernel? I think your report means that v5.11 can be improved...
I tried on stable kernel 5.11.2/5.10.19, and all reproduced, here is the log
5.11.2  https://pastebin.com/hG4iBETG
5.10.19  https://pastebin.com/ExFbQMdg

It' not 100% reproduced and sometimes can be reproduced within 20 times' 
testing.
I tried bisect, but unfortunately my attempts don't land on anything that
looks like the real culprit. :(

> Thanks,
>
> Bart.
>

