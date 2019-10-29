Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6787AE807F
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfJ2Grg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:47:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35328 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726752AbfJ2Grg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572331655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzeHimY7ewLinVm0WtVkZaAJ/B0VHllGPhwkDQfMHlc=;
        b=V7QCleUGAOZMwzNRjY318qsAVURPaeNSMtk/GuQpEYBvVSxBJX//9uzbSvEqIQt5qa2519
        gliXblhmIoNM8FOQV3GTwnfgeM+sSPi86tKqROrz20ct7xqXbC5s1u8/8PTDzxG2fJiKLn
        ayBYp+6w0uk6c70G9puinBGvh56YfDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-JhtX4_afOhu52YvqkRUZVg-1; Tue, 29 Oct 2019 02:47:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE70107AD28;
        Tue, 29 Oct 2019 06:47:30 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DE1819C4F;
        Tue, 29 Oct 2019 06:47:30 +0000 (UTC)
Date:   Tue, 29 Oct 2019 14:47:27 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [linux-next patch] RDMA/srp: add module parameter
 'has_max_it_iu_size'
Message-ID: <20191029064727.GA22221@dhcp-128-227.nay.redhat.com>
References: <20191025132318.13906-1-honli@redhat.com>
 <e797397c-3bfb-610a-bcf1-9cfdfc75c680@acm.org>
MIME-Version: 1.0
In-Reply-To: <e797397c-3bfb-610a-bcf1-9cfdfc75c680@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JhtX4_afOhu52YvqkRUZVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 07:10:44PM -0700, Bart Van Assche wrote:
> On 2019-10-25 06:23, Honggang LI wrote:
> > +module_param(has_max_it_iu_size, bool, 0444);
> > +MODULE_PARM_DESC(has_max_it_iu_size,
> > +=09=09  "Indicate the module supports max_it_iu_size login parameter")=
;
>=20
> Since the approach of this patch requires to add one new kernel
> parameter every time a new login parameter is added, I don't think this
> approach is future-proof. Has it been considered to export a list of all
> supported login parameters to user space?

ok, I will drop this patch and usespace v2 srp_daemon patch.

thanks

