Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEA632763C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 03:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhCACzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 21:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231892AbhCACzn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Feb 2021 21:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614567257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1j+xD5RJ8GQs46x6EyImDPRxYUCzKqNINBOTAQCWMcs=;
        b=HV0T/pvOH4f9OMazpb5zlAYIR0oxaFHBj2p3SQb/OdHCug77JU1dFhIxXeHJqsdCYSoVrx
        wnhezVILEuvQzicKJVh70jEu3CAgfboVpPM/mRNoLZLOnllVQztGVlqXLOgk81s0R5ZS8t
        8OkMTxL+vAip0SNqtD/mYy/Psl9ul9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-Qrs-sLJUPxetI8FXZMIZ7g-1; Sun, 28 Feb 2021 21:54:12 -0500
X-MC-Unique: Qrs-sLJUPxetI8FXZMIZ7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43117C289;
        Mon,  1 Mar 2021 02:54:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 316F660BFA;
        Mon,  1 Mar 2021 02:54:08 +0000 (UTC)
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
 <BYAPR04MB4965FDA9847096508E35FFB9869B9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <4ab0ac23-ad15-748d-7101-a1f964f338a9@redhat.com>
Date:   Mon, 1 Mar 2021 10:54:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965FDA9847096508E35FFB9869B9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sure, will do.

On 3/1/21 3:07 AM, Chaitanya Kulkarni wrote:
> On 2/28/21 01:52, Yi Zhang wrote:
>> Hello
>>
>> I found this issue with blktests srp/015, could anyone help check it?
> Until you get some reply you can try and bisect it.
>
>

