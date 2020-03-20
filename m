Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0813D18D320
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 16:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCTPlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 11:41:11 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:46344 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTPlL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 11:41:11 -0400
Received: by mail-ed1-f53.google.com with SMTP id ca19so7533188edb.13
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifINlaJF1GqPiyRkb4+OUZKAsOmgwBJbeF5tYPm2GrI=;
        b=EgdHjAdBSWGQ+bravSK8/FOt18mdLXhn4lJst3OIQylCa8JccEz4exo2u1eHaRhTB0
         Xu77cUkd8Up+BZweYLvODHgeqgVAr0MwdlrpkAfZHY2v13fJDxJUN44iunkhAVvzu+Bm
         wMsp4FbNbw1riNH586+6VXvTjX6wHywh3zlzhEeGh8Jw7cVm2D4qx1fchp+5He7DWg8A
         Oi3IvRW8m+cojM/89dEIy2fs4KSqOCifq/qSmiLDobMNF5ROMFTtdJjqw55yXCO7FLeU
         Xo+RAv0WEOj1BRVu71Tbjw8jw/JwFRuS+IZZ/0/VQw6K1csqdRjhL5r/+IRU6Z4KHGab
         uWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifINlaJF1GqPiyRkb4+OUZKAsOmgwBJbeF5tYPm2GrI=;
        b=LV+yr4GRWgVKrkXgT6clpLQ8aRy9buMuTMCOikMETNyDgf83EkoyQ9EsStV0eS9Ufb
         wp9dCPRcDiLLhGWXBJSEkgPsltrlfHSiRpNR9geeVPSWAf7KM2cCPsey6aHvlHwCqJhH
         BLj7YbGqXIqaOODNGxpewgwy2jbvCtEELMVgkXZ/+YJ+5SnisNrKCdUGLENpYtWWvefq
         kbnf9s0pfeEVX+qgaDxrWK0hqMKBwc324ksPPCVXOZueBNsV3Ut17lLZ8DdN2BcJFDjQ
         FIoXl3uA6sYpWscnhOEPVJUsMT4l1uS2KerOaAK05VgRCmWp6gJR1Yd63TJ1YjoEcRDT
         IJOw==
X-Gm-Message-State: ANhLgQ3BLN9XP9x3586jGC29V9yLkUxeXdsP+oD4z7f8IT6TpuH19qAA
        CgeRhfDuxjn5wZXYGhN3XpuRk9yymy7gZ4IRlnPu3Q==
X-Google-Smtp-Source: ADFU+vsE2eG6oiZXqiEwtQ+XmWghokSahQqLLpzXvJ7yfoa69sZUXrpa/pB+VG3/LjQH2hLxXll07pm0f2ymTVX7WUo=
X-Received: by 2002:a17:906:134e:: with SMTP id x14mr7665171ejb.80.1584718867426;
 Fri, 20 Mar 2020 08:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
 <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com>
In-Reply-To: <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Fri, 20 Mar 2020 08:40:56 -0700
Message-ID: <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     Mark Bloch <markb@mellanox.com>
Cc:     Terry Toole <toole@photodiagnostic.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Mark,

Just a clarification: when you say reach line rates speeds, you mean
with no packet drops ?

Thanks
Dimitris

On Tue, Mar 17, 2020 at 4:40 PM Mark Bloch <markb@mellanox.com> wrote:
> If you would like to have a look at a highly optimized datapath from userspace:
> https://github.com/DPDK/dpdk/blob/master/drivers/net/mlx5/mlx5_rxtx.c
>
> With the right code you should have no issue reaching line rate speeds with raw_ethernet QPs
>
> Mark
