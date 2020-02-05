Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EBD15295A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 11:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBEKlx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 05:41:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33554 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgBEKlx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 05:41:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so1824565lji.0
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 02:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0VqevwSe05wXTlhfhyBqBCFkOrlKwOhh2LRQOj/E4Vw=;
        b=UYILga5V7UxU11O65rMZzPwXR+FnULPBUpo1ixVPlQLwhz6zQY3tJx3MrhHtwuF+mc
         c8WhDluwZfgp/fkWWexwl1y1fsA4eeZlGUZtqkok7h257hLmxCRwicH/37zvguFvwyK3
         Z1FT3yGUAomxJseB5/BurWfK26zyXxAzT3REdKl8acZ52pFbukFeT3J0BsJ/83QYygIB
         6j+kvBY+5sY/GuOVyeMptkpFm6GK4iO/t2UXRmL+tT+nnHgYGcopMI2bbSMIEpGnDWDi
         B+hukTLcDmQrSBCvSLzEnoJ4E4zAOTuLR0ZUYRGIBpxkKPPiKv3Q20i7t7ZmOV8N72cd
         VP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0VqevwSe05wXTlhfhyBqBCFkOrlKwOhh2LRQOj/E4Vw=;
        b=Fc2G86929CzJtVHpah6/L3FU0dNkI3chBBu4LqA7PfT9b34eTMlCEaknrmj0ca/uFh
         cTgmT1tQ7JjZAMbZyMGJzMfQmvvhKZ/G0ednaEpXfu28t9gzphKPQSlCN6pJyeS5sqj9
         pT0oUwh1IFHipjQ8mt5MAB4J46Xpc0LYww/CEtAPKejLZHVW0CRLBjvKQF2JrHnpSvMn
         DW2txg5VH9nUGU/IkciJwYkFxvJQ2gG2hh5dxtLJZzplBT79EQr7lwEr7UKheOBdSaCz
         FxC4U257j6Xw6REfRKGG3Zo3Gl4sboQAANc4pwK4WT8+aFFaoA+sJlzuyShyqSzyZhL5
         78og==
X-Gm-Message-State: APjAAAUdIOKtfX94214Ve4DJ2bKL05GQjCVY88OoyaSo9s4x9+2jTVIn
        6IsGxh03vNT3I9bPgywCmrn5z1d+UNUMoshcbe8MLk4sybk=
X-Google-Smtp-Source: APXvYqwfOcIGv16QV+SrGlGXKNBaNVfCkNVdpXu94Nq59VJ+fmBbxgZNdF0dLjzXqo0AtnJF6htz62jSVuLtJSZOlaU=
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20312912ljk.201.1580899311570;
 Wed, 05 Feb 2020 02:41:51 -0800 (PST)
MIME-Version: 1.0
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Wed, 5 Feb 2020 18:41:39 +0800
Message-ID: <CAKC_zSv3TRgrqg_EX+ZqxQ5FecWk_pEFmDr2C3W=xLhijUOXWQ@mail.gmail.com>
Subject: why use _ucma_find_context in ucma_destroy_id?
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hi, all

I found that in ucma_destroy_id when using struct ucma_context not use in pair.

1,
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/tree/drivers/infiniband/core/ucma.c#n611

in line 611 ,use _ucma_find_context, do not call ucma_get_ctx

2,
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/tree/drivers/infiniband/core/ucma.c#n629

in line 629, use ucma_put_ctx

will this cause an unexpect wait?
