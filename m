Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D916BB1E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfGQLKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 07:10:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32789 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQLKC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 07:10:02 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so45107505iog.0
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUSZtZnyufm364FYvM4rEWW0SxESwuvM6YcV0s51TZs=;
        b=YtTLrxqMnxmV3rFSX3lIOG7/yNSYfCE1lGJYylQgzTYp5eoYEKg6RbBtjl5L7jiGom
         uAAEe1HHhoFV94pV1GhzbXgLe/5QlM4gSSKFA96p914MzjfP5h3b48BjGDl1NeHQEqcF
         3ltYaxsk0AuxyTyuwvOeT67y4x7MAoVNEguelpa8MZYaOAHK6qJ/Tgy72Zscb7aHzr5+
         23aDdKilMNsUS7s1/eIXDimm2ULoetYyeEWGrtJ4ObFgYyQgut6/xTEMzFQk9ZhapbEj
         gwezt5whgJ8PMApPC6Xd//IdHCTKpkT1z6rWG/el+fkyqblefiVshA62aAl8iUgWSzqp
         nHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUSZtZnyufm364FYvM4rEWW0SxESwuvM6YcV0s51TZs=;
        b=T22fp7TDEEl2a6XkTBCxJgcnfz0YV70ttNYrBe2NregWbjeYWGkUPG7YXXpcVx+xpB
         UtqdWFlDOB7aLox73S3fDeyTxTVVbFBgKHa1uxxVlN2TlzrP2HXqdncNmnuAr9b89Crh
         LuDCAsc6UrBJCwUeNtdJC6/WeFs+ZfXJqT/kouzXennKAhLYDX/Z6uVzGtQtXTc3pKh+
         ADpWcddufxiou/oRGzedc8TvUcC54MFrAblQdph6433rs6iDslZGSDtgmbfnsb7+3ZBj
         qBgi0yqVUJIp4A9OySJdkqY+0TFOEDGmyYjR/R3vr12wS7X7vRhjBoR7iC3e6mMqUra0
         18uA==
X-Gm-Message-State: APjAAAVcoZ3WEz7NdbhULSC+xT+CZotfmrBKvscIaw4zYQNou76MaXWx
        qf7i8FZVi5wb2Ra42B3hSntyJyRPY8OyLZqE9p0=
X-Google-Smtp-Source: APXvYqxW9PRhpxmRp9PoFHFDWjPNSMr8i9VZggTfGDOrwggk45qs/G+7yeFfVriQLB6wfxlgq3Y2G65aK7Wl9Q2HYNY=
X-Received: by 2002:a5d:9643:: with SMTP id d3mr37947005ios.227.1563361801363;
 Wed, 17 Jul 2019 04:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190716181200.4239-1-srabinov7@gmail.com> <20190717050931.GA18936@infradead.org>
In-Reply-To: <20190717050931.GA18936@infradead.org>
From:   Shamir Rabinovitch <srabinov7@gmail.com>
Date:   Wed, 17 Jul 2019 14:09:50 +0300
Message-ID: <CA+KVoo7oSdpX2j1hRT1gPFFrxkHLBfcxXh4HaxkjjNKD550sYg@mail.gmail.com>
Subject: Re: [PATCH 00/25] Shared PD and MR
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 8:09 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jul 16, 2019 at 09:11:35PM +0300, Shamir Rabinovitch wrote:
> > Following patch-set introduce the shared object feature.
> >
> > A shared object feature allows one process to create HW objects (currently
> > PD and MR) so that a second process can import.
>
> That sounds like a major complication, so you'd better also explain
> the use case very well.

The main use case was that there is a server that has giant shared
memory that is shared across many processes (lots of mtts).
Each process needs the same memory registration (lots of mrs that
register same memory).
In such scenario, the HCA runs out of mtts.
To solve this problem, an single memory registration is shared across
all the process in that server saving hca mtts.
Future expansion of this can be done on top of the new infrastructure
to any HW object that is suitable for sharing (mainly those that are
not saving important data in the user context).
