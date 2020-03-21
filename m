Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847D018DD83
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2020 02:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCUBnZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 21:43:25 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34862 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCUBnZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 21:43:25 -0400
Received: by mail-ed1-f52.google.com with SMTP id a20so9446941edj.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 18:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZsHR36uAh/kc03yNsuBqLp/d9Zya8yomuDWUON2GGA=;
        b=PlBVj9QOsvLkQSsLWKQp8xdO4/w/Ghshi/OOlF4P2szrPJkRd9X23GWfsOhie85gYT
         PsvBtPPDOXjW7MaBjaAagPYavz1utTsagWYVWCJCr8Ga2jnrNrGwpt5OxFUyi1tL049A
         aYAG9YV4/s81fsjTVfm1wC3BntBb5Xr0fr1drdusHIQ61LOgR5y2665OjUvAiVzmKkL1
         fPijjwlj+2nlZobWMiQEGKAxdmBFs5NG61ofif3CY3dlTY1YIy8wEJ1Ranw0hE4j6gcY
         tEbMOfK+6KZ2m+PSTB2zQaux0RM2DfVkwq/FjEhpozDhJsOMSuunrmon/0bjszSaDLhP
         LacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZsHR36uAh/kc03yNsuBqLp/d9Zya8yomuDWUON2GGA=;
        b=BCnnY0gDPAg998O8YW8vNxoL/nEPIeW/UKEMo4kiZR4spVNd78keXA+Lwh9oRBS82+
         h9kW4QeFIcSC/mP/06+KdyC0p//d3u6vPqepiLrVWI8kTYyKGojsIuJDr3ZQA2MBFAjy
         2RZJWE+6ThLdxCxtfSNqmmvlceKsWSbTf47k2BwNL2tN572yNi309pRtRB/UtbPDepha
         wh24wBR3I6leZuxXXwkT5cwd/laZh6Puwl96tuzhyPGOQzScmI3gYRlqWM2uOSbTljEk
         mEA0pB6wYTlVS8VKeQyipvIjOs46zyhCQgWhQh8HiIFIbu6DqqZzR3KgNmVgsSBymnIx
         2VrA==
X-Gm-Message-State: ANhLgQ2mloHF5YB+sA5/pixmHGF1XWSNDIXkm5i1zDIUwtZtLbsUqAhQ
        0R541qtNUGEgHjYyk6VK8hY/1xV2bZDRNHsEPk6wmg==
X-Google-Smtp-Source: ADFU+vsdy38EsP1y+t91TQMQ71Gj6NCCtZYt5n75uxrZOFpDIKXrShM5/rl+7UQ1RX0bH+wsI27Z4rfU5Jj6IPb+1no=
X-Received: by 2002:a50:ab1e:: with SMTP id s30mr11179131edc.336.1584755001508;
 Fri, 20 Mar 2020 18:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
 <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com> <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
 <CAOc41xGkcgDZoqPHX8uH4uG6E+FSUHMoZdB1H2cQ1X5LYkuM8g@mail.gmail.com> <20200320163411.GT20941@ziepe.ca>
In-Reply-To: <20200320163411.GT20941@ziepe.ca>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Fri, 20 Mar 2020 18:43:10 -0700
Message-ID: <CAOc41xFQBUXBLuVYXoTWEHxHHFnBFr=ABY8rx2Dtp6fe1A4ZOg@mail.gmail.com>
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mark Bloch <markb@mellanox.com>,
        Terry Toole <toole@photodiagnostic.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Got it. Thank you.

Dimitris

On Fri, Mar 20, 2020 at 9:34 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Mar 20, 2020 at 09:04:34AM -0700, Dimitris Dimitropoulos wrote:
> > I should make the question more precise: in a peer to peer setup where
> > RDMA UC can achieve line rate with no packet drops, can we expect the
> > same result with UDP with IB verbs ?
>
> I would expect UDP and UD to be similar
>
> But verbs will be slower than dpdk.
>
> Jason
