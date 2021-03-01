Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958183282A7
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhCAPiO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 10:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237300AbhCAPiI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 10:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614613001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLNNdUu1sjfy3lYGJToaIuw/3vCXTFj7Ta9EQpAP6XE=;
        b=ahO79pVSuIVaQyi9abwOO5lHEBqHppefrZYC2LQbfRbz3dv0ZlQDh10xuWk2HFxB5ZG+Ro
        EPBYMukagU8bPwGH2gv3FtqoC854sxeacvcvBajx1D/nSmydf4uHCxalilt0x9MliwUrVe
        7Eu7YMAsdiHXk8DQ60RCIyG3UOUO6FQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-VskzaCcYNZSmXo48o-qECA-1; Mon, 01 Mar 2021 10:36:39 -0500
X-MC-Unique: VskzaCcYNZSmXo48o-qECA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B76650742;
        Mon,  1 Mar 2021 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-197.pek2.redhat.com [10.72.12.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 379561002C10;
        Mon,  1 Mar 2021 15:36:35 +0000 (UTC)
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
 <BYAPR04MB4965FDA9847096508E35FFB9869B9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <8b1fc0cd-196a-ad78-71c6-a7515ffbb4ad@redhat.com>
Date:   Mon, 1 Mar 2021 23:36:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965FDA9847096508E35FFB9869B9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This issue cannot be reproduced on latest 5.12.0-rc1.

Please ignore this report, sorry for the noise.

On 3/1/21 3:07 AM, Chaitanya Kulkarni wrote:
> On 2/28/21 01:52, Yi Zhang wrote:
>> Hello
>>
>> I found this issue with blktests srp/015, could anyone help check it?
> Until you get some reply you can try and bisect it.
>
>

