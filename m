Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A6249FB7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHSNZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 09:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728518AbgHSNYV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Aug 2020 09:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597843458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JG7lykHHZDOhZibDTST22h7kjX3blalLhMbA84YoqU=;
        b=JDf9RW/jTStoZ9MP5pqdpR08ZQpAf3K01iv+OiQ8rrgGJVjfZfLVHunV3emkp/q1J+hdm+
        rJytL4c5Len6TdMtV1/Ed7I0WNUVe5xxhzJR2Xurb8smbcjDjPxIc0WQouwNYAaQfJcXOo
        bqvvls5MthxCrlfJyBgzFQ//MIREqvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-Uoxkl9T5OGqKRSQ9hbg5rw-1; Wed, 19 Aug 2020 09:24:12 -0400
X-MC-Unique: Uoxkl9T5OGqKRSQ9hbg5rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B13010054FF;
        Wed, 19 Aug 2020 13:24:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA33D5D9E8;
        Wed, 19 Aug 2020 13:24:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7007E1753B; Wed, 19 Aug 2020 15:24:08 +0200 (CEST)
Date:   Wed, 19 Aug 2020 15:24:08 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/2] drm/virtio: Remove open-coded commit-tail function
Message-ID: <20200819132408.jnqjhdgd4jbnarhh@sirius.home.kraxel.org>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <20200709123339.547390-2-daniel.vetter@ffwll.ch>
 <5cb80369-75a5-fc83-4683-3a6fc2814104@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb80369-75a5-fc83-4683-3a6fc2814104@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 19, 2020 at 02:43:28PM +0200, Jiri Slaby wrote:
> On 09. 07. 20, 14:33, Daniel Vetter wrote:
> > Exactly matches the one in the helpers.
> 
> It's not that exact. The order of modeset_enables and planes is
> different. And this causes a regression -- no fb in qemu.

Does https://patchwork.freedesktop.org/patch/385980/ help?

take care,
  Gerd

