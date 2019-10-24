Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62844E33C5
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbfJXNSR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:18:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730061AbfJXNSR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 09:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571923096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWJFts6FNMbrkAwOwUfQaeP4+5P5u1d4D4DxmY0T7+k=;
        b=WBtDAbN0iUonCfzzlqMXKB9N4g/DST3mzttS1xoFm9PFw6YRMenR1seJ09hFziCwiWTmEK
        kJA7bhRz3AnkKgYufv6s5bOAZuC2ZPYafsfQj7dAL/3b2pOMjeoLZ2ZHOF4VJZdP30oHiC
        U2pZH2Gi4VWa24BRudEYSje3stY2owY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-6Q1gQ-F3MsKIF6MJeRoLBA-1; Thu, 24 Oct 2019 09:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DC441005500;
        Thu, 24 Oct 2019 13:18:11 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76D225C1B5;
        Thu, 24 Oct 2019 13:18:10 +0000 (UTC)
Date:   Thu, 24 Oct 2019 21:18:08 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
Message-ID: <20191024131808.GA28509@dhcp-128-227.nay.redhat.com>
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
 <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
 <21142610-1e01-4ce8-635c-2fe677e69cf9@acm.org>
 <20191022070025.GA20278@dhcp-128-227.nay.redhat.com>
 <5f664232-ca58-c25c-e9b1-e441c053c818@acm.org>
 <20191023030641.GA14551@dhcp-128-227.nay.redhat.com>
 <20191023153357.GA9650@dhcp-128-227.nay.redhat.com>
 <3b632531-da0a-8c98-365a-076a7d0b3460@acm.org>
MIME-Version: 1.0
In-Reply-To: <3b632531-da0a-8c98-365a-076a7d0b3460@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6Q1gQ-F3MsKIF6MJeRoLBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 07:13:27PM -0700, Bart Van Assche wrote:
>=20
> This should work but I'm not sure this is the best approach we can come
> up with. Will one new kernel module parameter be added to the ib_srp
> kernel module every time a login parameter is added?

It seems we do not have better choice for backward compatibility.
I will send the kernel patch and srp_daemon patch.

thanks

