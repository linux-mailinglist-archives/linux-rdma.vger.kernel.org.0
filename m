Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E758151BF1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgBDOOu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 09:14:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42172 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727235AbgBDOOu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 09:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580825689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I0+kmwY48Xcdgem1DckaY2RMkt0kvx4HTGFEGY2SVQI=;
        b=Qcho1Zyz9Ixi6TVoEUmspxPEu1IYyLsZIlx/OAmkqUYiUUFLx1M39FunzIlP9JsSDtC/Zt
        6rTSkTC8SQcpibAkQye2T5G7PUhBYZtu0uKWbNBv0ysQX2WM1t9t8CyIA66AcD8qCRc0dA
        2kctsTql3CwEUNodfdWGtncAkonGvvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-2rC_T46AOkSe-uwye7JSLA-1; Tue, 04 Feb 2020 09:14:45 -0500
X-MC-Unique: 2rC_T46AOkSe-uwye7JSLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA6918A6EC2;
        Tue,  4 Feb 2020 14:14:44 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 842FC19486;
        Tue,  4 Feb 2020 14:14:43 +0000 (UTC)
Date:   Tue, 4 Feb 2020 22:14:40 +0800
From:   Honggang LI <honli@redhat.com>
To:     "Goldman, Adam" <adam.goldman@intel.com>
Cc:     linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200204141440.GA1062279@dhcp-128-72.nay.redhat.com>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"

Maybe, we should not enable device rename as default for all RDMA
hardware. Leave it to system admin to apply rename or not.

We are observing issues with RDMA device renaming too.

Thanks

