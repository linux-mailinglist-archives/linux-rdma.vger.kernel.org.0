Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF631370BE
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgAJPJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:09:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:41422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgAJPJq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jan 2020 10:09:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86A6DB166;
        Fri, 10 Jan 2020 15:09:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Jan 2020 16:09:43 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCH v6 17/25] rnbd: client: main functionality
In-Reply-To: <CAMGffEm3tp_hjQT2kw9yKbuoXrkF5g6f-3prvx6buHoT+Mpb1Q@mail.gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-18-jinpuwang@gmail.com>
 <aa7eeeda-b3d7-4a26-9043-53ce8c80eef1@acm.org>
 <CAMGffEm3tp_hjQT2kw9yKbuoXrkF5g6f-3prvx6buHoT+Mpb1Q@mail.gmail.com>
Message-ID: <2616c4cd0aabcd112256fe2e3d7b9a24@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-01-10 15:45, Jinpu Wang wrote:
>> > +{
>> > +     DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
>> > +
>> > +     prepare_to_wait(&sess->rtrs_waitq, &wait, TASK_UNINTERRUPTIBLE);
>> > +     if (IS_ERR_OR_NULL(sess->rtrs)) {
>> > +             finish_wait(&sess->rtrs_waitq, &wait);
>> > +             return;
>> > +     }
>> > +     mutex_unlock(&sess_lock);
>> > +     /* After unlock session can be freed, so careful */
>> > +     schedule();
>> > +     mutex_lock(&sess_lock);
>> > +}
>> 
>> How can a function that calls schedule() and that is not surrounded by 
>> a
>> loop be correct? What if e.g. schedule() finishes due to a spurious 
>> wakeup?
> I checked in git history, this no clean explanation why we have to
> call the mutex_unlock/schedul/mutex_lock magic
> It's allowed to call schedule inside mutex, seems we can remove the
> code snip, @Roman Penyaev do you remember why it was introduced?

The loop in question is in the caller, see __find_and_get_sess().
You can't leave mutex locked and call schedule(), you will catch a
deadlock with a caller of free_sess(), which has just put the last
reference and is about to take the sess_lock in order to delete
the session from the list.

--
Roman

