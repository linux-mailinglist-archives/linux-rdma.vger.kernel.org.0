Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95219786C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgC3KMN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 06:12:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33549 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgC3KMN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 06:12:13 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so17114858iof.0
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2020 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UCRav7GgrcqxbKA+bkkvE0NHFZyJUCyRM124ao2KOc=;
        b=VQHbi9zX6v2tgR3F4FbwxOPzjsF0FFhEELvhGotVCxdIrK/VsF0VqvyB8bAAonLx71
         0/7hOeVqkX2wO/G8v4+7SVRxz+BlP8S10+EFsMdiHX0Rw9eVIvD5t0aTx7z21JWzIdzw
         Wstca7pWtndZ0EXxDhan6vWbu5FC6ScdolzK9ZYMcVsrSH7q4Twst5HVGcsd0j2aLAQW
         mnTrdJzV89HgUmJwatM7aLY0AZkh/o+2yTNKxaU9IZm+M/EfX513qaxcb0qSY+E993qN
         5gcJGk2AabpIKt7SISUlliLUAYKHnRM/x7CF/7Hj7Zz5CJrFlHehjB4uNZrNEBOg0P3g
         3hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UCRav7GgrcqxbKA+bkkvE0NHFZyJUCyRM124ao2KOc=;
        b=F83YJAIpC7rhYq1ILi8y8qLU27UMZPcKgqYc7ByuvfkfqnS+c4NDQykeaAYpJpYBX9
         90sMj9zAc+xSt6xtCZXOYSq95ZkLg05+sWSC70k3Uu9YHk+SpKe275Op1uQzX8925bdo
         RVCzb4swHcJvO8atSC9UVd8aqazTQavmQA4DslV7m0uBfNIxAvsCXHVUjjAEp1aFqa2v
         vpfICKbiYtBFW3qX2ESl8W9rkVxCBEgxsVo05hrION5MU5bCti5YOXEnGkYCk42122Z4
         taOxRYHbzqPdBYcu1vU5v8SLG8jFU7bLI1U/rZq47TbyCJPJ69s3/Px6caeX8+M/2vMt
         P+Pg==
X-Gm-Message-State: ANhLgQ1XrWrMubQ/v7GAPQT+LnYdIbhJj0emM5uLUoTjPXeMvDig9OBq
        EXlEIv0Z8br/6nYCCVpEW/BOJwVCaPdR2oRO4BAL
X-Google-Smtp-Source: ADFU+vtT/GzRj1IXMIIpOT0PCASeot7yQEOEIH9W1EjB22I3LJCML5DIXJ3AjRS1iId3GK6kSKro03O/3YFC1zRgFxQ=
X-Received: by 2002:a02:3842:: with SMTP id v2mr10268615jae.9.1585563131996;
 Mon, 30 Mar 2020 03:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-27-jinpu.wang@cloud.ionos.com> <7e9a4b85-1062-da29-db8e-9298dc71719d@acm.org>
In-Reply-To: <7e9a4b85-1062-da29-db8e-9298dc71719d@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 30 Mar 2020 12:12:01 +0200
Message-ID: <CAHg0HuyU_WiwJD6+9=ZG_5pKNsjBXBtv7SnRxYdW4RjtKPwXHw@mail.gmail.com>
Subject: Re: [PATCH v11 26/26] MAINTAINERS: Add maintainers for RNBD/RTRS modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 8:40 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > Danil and I will maintain RNBD/RTRS modules.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks.
