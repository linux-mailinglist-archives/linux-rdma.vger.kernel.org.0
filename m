Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0B132694
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 13:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgAGMkK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 07:40:10 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36779 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgAGMkK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 07:40:10 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so45594215iln.3
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGGRxiRBeuUoiWYAF0rXXnn8VinREOmG6AvgFZVfjF0=;
        b=EWco4wtCM0tg/Uv33tzijxSlrHPELApc8ks6NI8bck5WaG9wwGjVuTiaBtrgGrGqW8
         Hwn5uxe6n+ZYfcCuB1oFmKZu4Y1FZilYebe4338pBzbupAwwJEFAwnnblMz9TG1EMUlo
         OWT6dfvN2BQnQ7uMIWiZUuk3Rbyu+uOQgU7pCxK2oaAetKJgKoNOdWhdfRa+OEnVaXUa
         Ktplks4DNSlz10DKmz5ID+lc33Lsd7Jt3+EngEU8x+SlpjZrJRoP7ag4DghuSQTwh4B0
         xQt/8QGJdKsI5ql8SEjIiFY1TTAh85eQihjgX0gGN7j8fX83xuPHgZBY09L2upQORYI3
         DkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGGRxiRBeuUoiWYAF0rXXnn8VinREOmG6AvgFZVfjF0=;
        b=UZG8sXmq1BULzEcs43fSjhNN8GaqWDvv1WtsxfmlIkaz+fBVQ5DnTBDpsmEqC/OUJS
         L4fqsvXF0h5ggR2QmPlD1MIucnremTaZzMWEKSO2fXB8WV6JiKBtebbLwqnI8qwEYDlb
         K+w6DUk7VidHnsQbWYXxhrd8D6TO69SpuLck5eCIZJNP615lCn6tBORZcu5pcbOc66Pm
         kZdf0sLUU9i1/LfzDzym5kSiN0Bw0rlTxtZtok7LUmuteasanf57rj0kr3ThyGXv0brz
         6/PXrWK+0yRYZy5hOOn9QXdV/8EqGJcdA/BBW5QCa8TjFCol0tteEkMz8dRM3sMrl2Im
         6qqA==
X-Gm-Message-State: APjAAAWfzQUMdml4eRdk7PAAn+xziYJvZomZlbwb3+7WbF3ZvpT/AN8s
        QTdAtuXAeQpxBGb1zHK2U/NPusZKp6NoWvDedhALxA==
X-Google-Smtp-Source: APXvYqxWS25mAwzf+btFu9iMsX75112qkScfAdWSlCRJEpUdX9St839L2ZpwR7Ow6LDs3v3CORrtkhFTvwUSlybefrc=
X-Received: by 2002:a92:1090:: with SMTP id 16mr87451291ilq.298.1578400809537;
 Tue, 07 Jan 2020 04:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-6-jinpuwang@gmail.com>
 <db1bc453-7ea5-978a-7418-af05c7c8cba7@acm.org>
In-Reply-To: <db1bc453-7ea5-978a-7418-af05c7c8cba7@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 13:39:58 +0100
Message-ID: <CAMGffEmNuVVJCFBdszevXRdLeFB9RYP5cYWuX6-psRXESV4QtQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/25] rtrs: client: private header with client structs
 and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 31, 2019 at 12:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > +#define GET_PERMIT(clt, idx) ((clt)->permits + PERMIT_SIZE(clt) * idx)
>
> Please surround 'idx' with parentheses.
>
> Thanks,
>
> Bart.
will do, thanks
