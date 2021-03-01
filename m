Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62237327641
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 03:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCAC6L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 21:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231375AbhCAC6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Feb 2021 21:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614567405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tF2SzLmHGV0nKEFk+Qe+i3CtUxgDS/14vtHfggtzYVQ=;
        b=LAWvslUpz/FfV4oqfstI83DvIIumgrNB7C3ec3xjnV0S2RDeEsNfUTG4q6eA+lkP3lZ+XZ
        9Mpgput1aOX/AZsA/8GHUUqs25QL1i9bTcasdRj+Xs5xWGPdjLiPPZz3r6DkRkvWp0VhHn
        aPfqmwDXzevgo0ArV2PYtbo2TUBaAY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-CagwHZ9_NbejKZyAzeGVaQ-1; Sun, 28 Feb 2021 21:56:42 -0500
X-MC-Unique: CagwHZ9_NbejKZyAzeGVaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC114100A8E8;
        Mon,  1 Mar 2021 02:56:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4F645D9DE;
        Mon,  1 Mar 2021 02:56:39 +0000 (UTC)
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
References: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
 <2457b558-bbb7-b6b8-1cb7-94fd833fc1a8@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <7209abc8-17e4-4a7d-fc9c-12e17b88ae18@redhat.com>
Date:   Mon, 1 Mar 2021 10:56:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2457b558-bbb7-b6b8-1cb7-94fd833fc1a8@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/1/21 6:04 AM, Bart Van Assche wrote:
> On 2/28/21 1:49 AM, Yi Zhang wrote:
>> I found this issue with blktests srp/015, could anyone help check it?
> Which kernel tree has been used in your tests? One of Linus' trees or a
> for-next tree from a kernel maintainer?
I'm using "tag: v5.11" on Linus' tree.

