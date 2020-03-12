Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37756182CA6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 10:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCLJoC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 05:44:02 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45092 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgCLJoC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 05:44:02 -0400
Received: by mail-il1-f196.google.com with SMTP id p1so4815900ils.12
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2020 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAqAg1W/QYHpwDepJfGAlCUIanZke/rA+gmrT74RYO8=;
        b=HQogJVDjkSkOz62zrX2J96oZm2a/a+T1G0N1iwcP8cq3sXort+Y1D2GIichhCocA3R
         iJH09SZJAYhB9WWvYZ18YybbiM7pjmHT723+O1dFldvWumCGgPsHRPWZILsBCNIfw0Mj
         bI/RkecADGUD32bIjXCGTqh4gLkplNCr+DMQAT6hSoaUl0DwLlajC7NqKstWmpOG7/wX
         ixbCPzXvaSBWpnds1neZWChSv8FsqYJ1bjb8QaKXtPPcb5VrI2IMijVwP4bdUKiyFcGL
         kXUUcjH3uGsGTeFwYF4xWwdPvUXfgelGaEDpycpnD+PJOCRLJMQSK2xZkgRpFsuVSbNv
         qKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAqAg1W/QYHpwDepJfGAlCUIanZke/rA+gmrT74RYO8=;
        b=YzctfzVdEF6mej5Daya+DAoQ3TVcWm6kIEJswkrULi07eQtc8QEpQByeIJAOKfqDf+
         SnXdI/v3qGfhLelWmaqN3tavGwzydAj1X/eemfWTkCHItM2/Npd6ZfMgGrRiyrevHtmV
         tsVVXqBAiC1fPb0EYD+FuIKXGylhbNF+CH9m91daFXZeGSt3+S1CXRhU8N3PF7y5YR/7
         EEVOxeJX+OpdO1axFLio7DsV+loXiKIYHD+2SyOc76WvZqRqI9hrCIZCFsi5ZvOpcZoI
         RawrdY/2Nh2nSx+PN7eECHy1SlEZxe2H9n/ff9yRgkh0j0PdHqnhJ8uwGkvpFmaiV1k3
         2Wng==
X-Gm-Message-State: ANhLgQ0odc+Pem2ShvpjAV4tyO9xDVsYn3qzTOdPvGZ6YztSS59ID3Vz
        Kxj8xTcHpE7UXp+eFyGuUgfmieq6J3m5wbLqQLeOXw==
X-Google-Smtp-Source: ADFU+vu8sSSDN7E8Wy31R2p5TINDo+XVh2EwbdccEr6pRA1a5DwwmyMO8ulTyryzImhE69hcMP0p+VFg+hVcKObQGOU=
X-Received: by 2002:a92:a1c6:: with SMTP id b67mr6944350ill.298.1584006239676;
 Thu, 12 Mar 2020 02:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-3-jinpu.wang@cloud.ionos.com> <20200311184522.GG31668@ziepe.ca>
In-Reply-To: <20200311184522.GG31668@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 12 Mar 2020 10:43:48 +0100
Message-ID: <CAMGffEnQQV5mzYsPs4U2UcE_moFzHk75j5skmA2c3wHfsTnykQ@mail.gmail.com>
Subject: Re: [PATCH v10 02/26] RDMA/rtrs: public interface header to establish
 RDMA connections
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 11, 2020 at 7:45 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Mar 11, 2020 at 05:12:16PM +0100, Jack Wang wrote:
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
> > new file mode 100644
> > index 000000000000..395d1112f155
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs.h
>
> > +
> > +/**
> > + * rtrs_clt_open() - Open a session to an RTRS server
> > + * @ops: holds the link event callback and the private pointer.
> > + * @sessname: name of the session
> > + * @paths: Paths to be established defined by their src and dst addresses
> > + * @path_cnt: Number of elements in the @paths array
> > + * @port: port to be used by the RTRS session
> > + * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
> > + * @max_inflight_msg: Max. number of parallel inflight messages for the session
> > + * @max_segments: Max. number of segments per IO request
> > + * @reconnect_delay_sec: time between reconnect tries
> > + * @max_reconnect_attempts: Number of times to reconnect on error before giving
> > + *                       up, 0 for * disabled, -1 for forever
> > + *
> > + * Starts session establishment with the rtrs_server. The function can block
> > + * up to ~2000ms before it returns.
> > + *
> > + * Return a valid pointer on success otherwise PTR_ERR.
> > + */
>
> It is not so major, but the linux standard is for kdocs to be in the
> .c files not the header - to make an index of kdocs for browsing I
> think the sphinx stuff is supposed to be used.
>
> Jason

Thanks for the quick reply. Bart suggested the same in the past, we
thought kdocs in .c or .h both are fine.
To make  the sphinx stuff happy, we will move the kdoc to .c file.

Regards!
