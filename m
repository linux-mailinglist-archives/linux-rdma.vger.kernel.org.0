Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35F2DF7C1
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 23:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfJUVvY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 17:51:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUVvY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 17:51:24 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MO9vD-1igozb3mZt-00OaQg; Mon, 21 Oct 2019 23:51:23 +0200
Received: by mail-qt1-f169.google.com with SMTP id c21so23531280qtj.12;
        Mon, 21 Oct 2019 14:51:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUl7miOQVJ8Ll78JbJ+jD05nbDzQ1XaTLJeoiKXCAEjxtSGOjos
        wZ9gOAhoHQrEzzaeC6Und2fOJR57zeAvg1++ELI=
X-Google-Smtp-Source: APXvYqyCN/qhmnUIWj6me414cr7Lci1nlxK5T+JI9OkdD86mKnXDdgrN/TkcUpyVgN/kbH0IRPf1xC1GwdOsBCLgrHc=
X-Received: by 2002:ac8:6956:: with SMTP id n22mr3434qtr.7.1571694681728; Mon,
 21 Oct 2019 14:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191007211826.3361202-1-arnd@arndb.de> <113038cde3f1335ba9bf4d66f22f0a536b70ef1f.camel@redhat.com>
In-Reply-To: <113038cde3f1335ba9bf4d66f22f0a536b70ef1f.camel@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Oct 2019 23:51:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a071AHaN0Jb9dX5c3syQZZPgaR9bX3V3nseDTsPvgDWGg@mail.gmail.com>
Message-ID: <CAK8P3a071AHaN0Jb9dX5c3syQZZPgaR9bX3V3nseDTsPvgDWGg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/hns: Fix build error again
To:     Doug Ledford <dledford@redhat.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Xi Wang <wangxi11@huawei.com>, Tao Tian <tiantao6@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pq1XGZ0b4uEi1Gr86mcw4diuty+KPz3mEOcebYLD0+Gpq66s9zb
 O1/te0ZqWiVSOXZc6AaQycnw12lBXUpiztuw3z60B7xO/17FY82vOwTLmEy2CKF3zWQBVE7
 reoFCl4LBtjnemo/RngtnQcF0sKrFbY+Ixbii9HC/mefi+LD0+TisYdI8ZADJPO+zSzbYBi
 ilHlmkeSIgTRic7jhAovQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dTPv17pHJM8=:xJAx6WTTXT7hSkm+vwwqVE
 C2ZQdty5BIA9Zk8jk5jgThUH23Yjh5GFyN/RDct3vx32pAvGThP8/JvVehVEDYSCR2dTnmS2L
 Mz6QW8aUNRrwXmZApttV4FP1+bCfhIQWVxeInHWR0ncItrDQLlxlEvG9TLJblCy+ii0G+cRsa
 etgvxPp+45d1Yl3EdJhIbl1NoJQh7/0t4cXvqI0vNvOS6ELMya4W5o5kPugvBpWz3v5trxPh6
 lBKpMsDiSWVrx9g+KvFJw91RnIBleoJ5iX7GNn6Etp7Tpw8LnqK4vyiJsTf0lgBY9uEisGg7i
 uL8P34VPa8R9zGl0Ri38QLPZG8MdenDG7N4FahYakD7eGDx+migtONaHtSeG/ONtXaX3O31JL
 hb2C9HPguxO+J7jbvWh8wbtAiQZgx4/wDvUznEFiaJ/4takTXUTn55Sbdy5pbyATLQ31Vqx7y
 dMQ/gFxSKirURFtN/OxGduK5pF2UrnEQ4GEVBhvCd0bit3Kbre+VWS9rTxP2qDYmK1OJpk/wB
 pSuXZBKipas9RaqyesckF1oni4ltKUcNT/PG9t/9jpiDDcSjP5I38YSqQm/q7JLo6aIRHxzgn
 yO/fkFNj/H0Kq6JYdmmbq73F69FdazQEBioXZ/DU5Qp30fBU7z8uTEKzGu2Ak0h8KoRCoIYmZ
 BUuDq23G1Dv2AFXlhYHQqTECUhxzQIA6YWyKlfvPQEk4T61jeAKVst3hQ30P2MpNlpF2ILLiB
 puax3yxuMin6qS0jo+kvgMA0BbCvjdJhaXqV/Twn/AnV13eiVzm/ajRa9QUCxQ80mnuEgL07B
 9RL6mNWV82jAqj2JxShNusqf84JrMjwUrVgtLzPMrlSlOiDVeAyrN7+YgWlCANUK1D4RqO8i2
 3vGXsrVRDhCCbIGCgELQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 11:09 PM Doug Ledford <dledford@redhat.com> wrote:
>
> This fix looks reasonable, but since I can't test this at all, and I'm
> personally tired of trying and failing to fix this issue, I need to ask
> if you've tried all the permutations for this just to confirm it works
> in all valid cases?

I'm fairly sure I would have found them all by now: Since I sent this
patch I built 4680 randconfig kernels, 293 of which had some HNS
driver enabled.

I also like to think that I spent more time to think it through in theory.

      Arnd
