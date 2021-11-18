Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC13A456493
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 21:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhKRVAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 16:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhKRVAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Nov 2021 16:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637269044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NQBbG9QmTVcqddRSnEaLzz0lzHtBjDf0FXQnKCmTPXc=;
        b=cJcI/tzgZlzD+Ha4Ruz/BhscLwQaiNT0Elrg/bbVgOY1fw2tlMTZHKM3nHaiwWc98hghLE
        y0HLtXVrvoxOI+VaoYy0sEDxJ9lQRNHHSWMDokMaKcrcMug6up0B4Wgu9vZxz1tvYvcffp
        I6XVG8wEfswr7TWWqfn7O3tNXbXbdoQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-Ry6abPMfOL-xo9tg6SJYrg-1; Thu, 18 Nov 2021 15:57:23 -0500
X-MC-Unique: Ry6abPMfOL-xo9tg6SJYrg-1
Received: by mail-lf1-f71.google.com with SMTP id u20-20020a056512129400b0040373ffc60bso4983912lfs.15
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 12:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NQBbG9QmTVcqddRSnEaLzz0lzHtBjDf0FXQnKCmTPXc=;
        b=J5bRaC1cerKYepmT+9+ZOYryvtxBIPrWKl8voDSfD0WgtzfQI2mc7znnXEvBT5XSfF
         30gJCnrabrzbhg6m2pAgph+qGo6R/aS4Kt7JDBe3YpPdnYf0zIP+Nn4+SC1D1HMlJdFd
         6KT9qIxPydc6rI7VAkfN+yInaFH5TuJZgYf/W/Hq8Nt9uYcdr4PZh0lT5IpMAwIcVwxH
         lhTR/aVlozhmDaTRhCkqiJk548fhoC1I79LbqNr+gzrxmgUzx5ayslbr2u+6EW5KDjoC
         MR8CDp4Olp5EqWI2BFUqEyl9jmfLb/7IkLuATOLzC2D9TjKcA25TPSB3FAp9hWS3E3+c
         sfgg==
X-Gm-Message-State: AOAM530YVI+72BmORoMkLp0OFr+RipP5W5OZm0ITa3vdYwKRPerZ6tzf
        7uwJq5I6G8hUUeInHnCtT/OUcRhdOYtBWQAK0Ef774fy04Yaa/ZJBxjRCppYlCf1f70+5G+yrLG
        dEhc3NulFhImsuj7EZjgRhANipw1UTfyYuTLz/Q==
X-Received: by 2002:a05:6512:3b9c:: with SMTP id g28mr27118760lfv.651.1637269040058;
        Thu, 18 Nov 2021 12:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTaRMwXMpoLtKNnYltwOZGOutPJGqpykob6vTeKBULyneKUI270vMiapyZdI0s1H2xCGUkSVLpF1P4tchJ1Ks=
X-Received: by 2002:a05:6512:3b9c:: with SMTP id g28mr27118741lfv.651.1637269039871;
 Thu, 18 Nov 2021 12:57:19 -0800 (PST)
MIME-Version: 1.0
From:   Doug Ledford <dledford@redhat.com>
Date:   Thu, 18 Nov 2021 14:57:09 -0600
Message-ID: <CAGbH50sEwKeB3bH6XHm+C1R_giN85pi6Bqq4fk-rFq-iU3bavg@mail.gmail.com>
Subject: Two announcements
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

First, many of us have talked in the past about the benefit dedicated
testing of the upstream kernel and rdma-core packages (as well as
dependent packages, like libfabric or openmpi) would be to the
community.  And although people thought it was a good idea, no one
stepped forward to undertake the task.  So, the OpenFabrics Alliance,
and by extension myself as one of the working group chairs for the
FSDP Working Group, did.  Many of you probably saw the announcement
this week that the FSDP has reached phase I complete.  That basically
means that the beaker cluster is up and running and the test harness
is functional.  The next step, phase II, is to add a CI infrastructure
into the cluster while also building out the testing repository, and
then enabling that CI infrastructure on the upstream kernel repo as
well as any interested user space repos.

As I'm sure many of you have noticed, while I've been off doing these
things, Jason has carried the burden of RDMA kernel maintenance on his
own.  Since adding the CI infrastructure and getting the initial tests
added to the cluster will not likely provide me any more free time
than I have had recently, the second announcement is that I'm going to
remove my name from the list of upstream kernel maintainers on the
RDMA stack and the rdma-core user space package.  I suspect Jason will
likely work to enlist some help to the upstream role, but I'll let him
elaborate on that.  I'm currently at SC21 and will send a patch to the
MAINTAINERS file when I get back and have access to my kernel repo.

-- 
Doug Ledford <dledford@redhat.com>
GPG KeyID: B826A3330E572FDD
Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

