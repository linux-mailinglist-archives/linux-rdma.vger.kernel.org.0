Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F847264A11
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 18:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIJQmr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgIJQi4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Sep 2020 12:38:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A31C0617A4
        for <linux-rdma@vger.kernel.org>; Thu, 10 Sep 2020 09:31:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so7407540wrm.9
        for <linux-rdma@vger.kernel.org>; Thu, 10 Sep 2020 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8XrenaZC7x7EEzLKgWnRWWP3kw9ET6fFDlth4Zp/gtY=;
        b=hS3ujk0SNbO+KKIhwCtkhoaR3D4iaqKNbu5obxXUIkUAIZEavvzLtR/AmkXCcWoApD
         6qpvZyIpj9MYpkAyH9G8uDL9NSGEi/1lDmYfV7LcqkQ60EBegndDFNwM8JmtO545n85S
         MOg1C3tt9lgEWQfDFA9RZTtn4r+yEtCoUD0KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8XrenaZC7x7EEzLKgWnRWWP3kw9ET6fFDlth4Zp/gtY=;
        b=rCd+5jpDdnakOwZg6/pJmYunajGejbGgImDAm7sINdOQDtbPNdZgvDQVOJ3OzCJ/M3
         rg8+dGrnUCfAd3qg7M+ROQuTzrG9pztuoIZ4rNyTVl8aYnGZJQsFGDj392k4mOOa6ccc
         g6BdVr8PanOw8RQmm4UEQ+HchUcpkIEWDLuJYkcPMqO+ksBDqYJR9CeaPJMjI9lnctXD
         spf4U8uCc3v/+R/W/eWHf5ZqZA7E3x7yme9fTJ/wM3j52FejT/y3lbosMVwqQiCV1pfN
         bTYSjlc3MzGXrW83Jqj28KnZhWUJpTc/z+Kz3MS5pCujghzjARzIt1a4qdbkuKmCePR+
         7LWg==
X-Gm-Message-State: AOAM53079+IMllww4PEQe0NN9SwjO3ablRgt1Zo7FsWIxuf9B1u6/6Nn
        Q59z+d42CoHRD4qOLM1un/qhKj5hwIAiR+IeobJMRA==
X-Google-Smtp-Source: ABdhPJwcM1WR8tf/ZS8yQwLpBis3MuAq9iXnzyvBX/Zvx2Mb7vIdbYBdQkdSZNftBa2+3D5j79NwEzxaMX89slqGZpY=
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr10703282wrx.182.1599755508951;
 Thu, 10 Sep 2020 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <f79159af-4408-dc2f-6efa-45c5b45cf2d9@web.de>
In-Reply-To: <f79159af-4408-dc2f-6efa-45c5b45cf2d9@web.de>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Fri, 11 Sep 2020 01:31:38 +0900
Message-ID: <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
Subject: Re: [PATCH] qedr: fix resource leak in qedr_create_qp
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-rdma@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Yuval Bason <yuval.bason@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Thank you for your comment.
I will re-label the goto statements and post the patch as version 2.

Thanks,
Keita

2020=E5=B9=B49=E6=9C=8810=E6=97=A5(=E6=9C=A8) 22:24 Markus Elfring <Markus.=
Elfring@web.de>:
>
> > Fix this by adding a new goto label that calls qedr_free_qp_resources.
>
> =E2=80=A6
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> =E2=80=A6
> > @@ -2165,11 +2187,13 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd=
,
> =E2=80=A6
> >       return &qp->ibqp;
> >
> > +err2:
> > +     qedr_free_qp_resources(dev, qp, udata);
> >  err:
> >       kfree(qp);
>
> I propose to choose further alternatives for numbered labels.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?id=3D7fe10096c1508c7f033d34d0741809f8=
eecc1ed4#n485
>
> Regards,
> Markus
