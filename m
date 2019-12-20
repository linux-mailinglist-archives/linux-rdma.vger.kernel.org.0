Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C212809D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 17:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLTQ0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 11:26:43 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37404 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTQ0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 11:26:42 -0500
Received: by mail-il1-f193.google.com with SMTP id t8so8439655iln.4
        for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2019 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XckgZbhUqnPG5tRhtRl+VwNraSkfSgZlNelmEK6ect0=;
        b=AEuugIbB9WF845MSH5WI6aAhvlU0SMwnsAkN5hO2bYAsqNIwrUOXb5eSnBTsDtYftJ
         jjtpHfTfy7MvgKkeQ+aJ4scdVeZKOb7UNymDQjdYn9K290SGfuYR3Hf4wyqfvUIdpBVy
         xGnMQHopqgNrfj0GHWMUCmEy4+hBc5m9SBXIQz0b/3v6Hc9f2igwwqhCqPvqdEGD4SgH
         alwXEnkX19G7hb2LjRi97+NG4ndRVomaLuZpZ6gutg/DTRC6gggGLBEdX+1WG7yh0S29
         qCQd2aZpQmfwWcgneT49zSCxvqrBpL7IDDube6EDsAzWPfjlLHYrS4fbBvM9Ntabozew
         0FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XckgZbhUqnPG5tRhtRl+VwNraSkfSgZlNelmEK6ect0=;
        b=DE/MR1r5FaNQegQtjOdm37xAB6YFOPdvXhqDRf0p1wjupbG4fSaV79zc37vqOh9PE4
         MGatHzialtQMU6p/oVblEBplEUJ+ckJjRHIi3Eztjz69xD5UWG4aFCoIilyZCYLwOn66
         v+yEU+A6arWIae4o9AUWcaY4i9NyILVW1bCVIqdJFUCRMt/t7IKtS7QNwEcI6ukyZDu3
         psQRHpq+twlj5rGdJkrHOtbVse4eOEXepBaw6HoWxYjylRAec41jahyBB0P0etQBbXfg
         2xRhLInpSjrNyl0UuwtLP5B7kclwqpA6ra5t9WpUatZIxWFFa6vPejexTfueH710kRb2
         Z7Tw==
X-Gm-Message-State: APjAAAUChDvfPGh4Th9Z+HyLEfn8+c5eIOGQ3qaokv7Es8OEDdEiRjtP
        H0gHWGxfSmuU+Jp0m1t8xce9U2NSHMdiZL/E2d/5iA==
X-Google-Smtp-Source: APXvYqwuLs7NjC3AP9OHJgs9RHyJryAKeItR8Tg55boVjTWuxFzoVgvETeExPk+NFhdbfwfZE34jAox3WSo+hyDsZm8=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr13316300ill.71.1576859202125;
 Fri, 20 Dec 2019 08:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-2-jinpuwang@gmail.com>
In-Reply-To: <20191220155109.8959-2-jinpuwang@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 20 Dec 2019 17:26:31 +0100
Message-ID: <CAMGffE=GDo8BgKGXpvTHZNOuCXViyfG2QfOzNDpCJR9kjFSnmg@mail.gmail.com>
Subject: Re: [PATCH v5 01/25] sysfs: export sysfs_remove_file_self()
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.iono.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 4:51 PM Jack Wang <jinpuwang@gmail.com> wrote:
>
> From: Jack Wang <jinpu.wang@cloud.iono.com>
>
> Function is going to be used in transport over RDMA module
> in subsequent patches, so export it to GPL modules.
>
> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> [jwang: extend the commit message]
> Signed-off-by: Jack Wang <jinpu.wang@cloud.iono.com>
Sorry, I made a mistake, the email address was wrong, should be cloud.ionos.com,
I've fixed it locally, it will be fixed next round if necessary.

Regards,
Jack Wang
