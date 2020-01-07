Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1B132B75
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 17:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgAGQxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 11:53:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37640 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgAGQxX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 11:53:23 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so33494ioc.4
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axx5QWtMxq2b4c/GsWxRCsq8m0TaNSUhoal+YFmgkSg=;
        b=aTXBE9F/TW8mZyTYXFXXTY3Vs8XyRFCzFdDh33g69hbFsQE9qicbvE2YjDfPkM8J3u
         qkE9V4oOClLFW7x36ICgwy0qYK/yJnW7OAJAZ8L3xZi/jwjJAhOduMJpGQKg+QHcjd9u
         h2+sB+MLS/fY7+GPMteeSEmE86W4m6kbzmze8lTWtkladfva4i66fnvU2Qi+PBCX29oJ
         eCD9GiobI2VdZwLU+kfmYAdPK1wH4mcTVcVErSRl7f9m77i4uvuJQZN0ZQHwHezq+V3H
         e/bZKMsiC4WTgcNDg6iRimJIY7dkwt47MpPBCpS/qKiwC5yI+EGgsSOTPxclsmP2CXZM
         0r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axx5QWtMxq2b4c/GsWxRCsq8m0TaNSUhoal+YFmgkSg=;
        b=nPw/k1uqgxBPmnjRx/cNI/SbKXVkpcP9jHUs5+aSCumiFgCbLzDmMTYOzDd3JfrE6X
         KMQzwV/HdYYEeIkGjGUmAjuiwfwm6USUD7uLq2b0WR9s3rDkeOY/4Cgwejno+F2JHIik
         grPslDWDcrxwC/gEg5OPbq8KtV7ElcnI1VcRWC3iCSxgZgvFZ/kSRJ8ZwVuND495sMzY
         6S0cYOCQQ0mfEfkBhpVcxfUVOVHp6zu3TlUADRrcA85qdICf85pcJTwymMK7SFDijzOj
         75jCRc14OWWTDEgRdzsEMHWQoabBnqKUiaN7W3eKZkRdVuPe1aDUvwnyw6ey50GaDQEr
         LdGA==
X-Gm-Message-State: APjAAAUs3sStALOWcQrihlh5fECL/w75pHEGvawcdNDPVq8p8OI3TKOq
        Yqo+Y02P1uOaykI6EWfG3exUbuOw7SI5S16j40xoBg==
X-Google-Smtp-Source: APXvYqy1xVOPCpEMetKlvx52b/dRNErOEuOtZUmRKb2MO12RH+NYkGwP4G+fVNpiS/3HtAtzYhj3Aj5vu0sNmeM6Ye0=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr75502479ioh.22.1578416001599;
 Tue, 07 Jan 2020 08:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-16-jinpuwang@gmail.com>
 <f8ec030c-9279-c5c0-617b-26305327a3b0@acm.org>
In-Reply-To: <f8ec030c-9279-c5c0-617b-26305327a3b0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 17:53:10 +0100
Message-ID: <CAMGffEk1DO6atu6V3OUJ2PbqauVFLLwNjqB6jvpLGpS8jhX2+Q@mail.gmail.com>
Subject: Re: [PATCH v6 15/25] rnbd: private headers with rnbd protocol structs
 and helpers
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

On Thu, Jan 2, 2020 at 11:34 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > + * @device_id:               device_id on server side to identify the device
>
> Is this a number that only has a meaning inside the RTRS software? Is
> the role of this number perhaps similar to an NVMe namespace or SCSI
> LUN? If so, please mention this. Additionally, does this number start
> from zero or from one?
device_id is only used in RNBD, RTRS doesn't care. we documented a bit
in rnbd/README,
we can extend the doc.
it is similar to SCSI LUN or NVMe namespace, it's an id to associate
the device with IO.

Thanks Bart.
