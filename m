Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55312BEC2
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Dec 2019 20:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfL1Tui (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Dec 2019 14:50:38 -0500
Received: from mout.web.de ([217.72.192.78]:60589 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfL1Tui (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Dec 2019 14:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577562613;
        bh=gVkocQ6dvTlNJZDA/nSvVYaaGzqc+Yg6goCIHCtEybU=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=IK/iM2RdPP17FqTKtrt4sJJamY+cLhiGPYGkaR/dTKAgZDJpOAfJO+l7qH+6bjsmH
         +/NfZBaWlYCOeR4Sz8T4XXsXo7LeC4rncb7++aGJf6tbZdq4oetkUtJdieNFQMrofz
         caJqPPfFX5YAe2xdNjCGgv/+Y73++0pMRlcmMqDM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.3.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5fsK-1jiboj0Hlo-00xdaw; Sat, 28
 Dec 2019 20:50:13 +0100
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kangjie Lu <kjlu@umn.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yuan Zhang <yuanxzhang@fudan.edu.cn>
References: <1577366516-19556-1-git-send-email-xiyuyang19@fudan.edu.cn>
Subject: Re: [PATCH v3] infiniband: i40iw: fix a potential NULL pointer
 dereference
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <29610962-92d4-2989-f18c-fa4a0a13ccb4@web.de>
Date:   Sat, 28 Dec 2019 20:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577366516-19556-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AO7i+cISfLt0FtG3yWD5ETpUfo9By9c5U4OWdLtgUG3d+SwnNk5
 l6WTaX7cts+YkFWnSaBqLVo8moascvEpCvxVavDViHA3tUM3wU1irGPrWSfH6XSiRnpAHT+
 CM1XkeRh9mPLJ1V8BP1OR2BfT9ZfaCkf5YvBJgz9/Ef7jjwhuqa5CaW3eni0jlAzx28PEV+
 OHQUDarsV8jKUprsYH6Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SCp/jdZ6XDE=:j+xW+fQYZjEhM/nmz8N0Ee
 T6j/u1XAQGWNNJLTYptcM9yhnWfgGIRJodNZTSeLby3iauIIRE6ku8FtX+TeeXYtP+dFKJyAN
 fxErf3tvDNRm0GQOBY813AB9b60AsSDOvzsRNw/1tebPQcmj1Q54ZCsOt5SqqXaLLMBUiGmER
 c9uN7/isvMNfe7bKyzPN06Oc6CjtvPlvwRTzVUDpX2PTpYaR33MHpz3Q8VSQw2J0dPnHlNYtb
 Ry0s+wiWQF4TbDqIVC1ItY4AxksiaOogwpLbqvdtnWCVh4PZBnSu0KCe1rs9DDYzSu+YKTIDd
 zBEoK26M3w0X9FkMQRkFEPbCrujz4t2MT5j/sqF0gb3dT0HJUNCuYN3M4VjIJ2MAoCrZHFFvd
 uUVfDxiYYFcbjSsOKbodMJa89pCGA//9VywKqIxrIebe56VnCyu5DsQMxXO0rTKtGrxsys2aG
 0ruFAnqjOxQOW5OWhe6v/L5bPxzyJiOSFf4J6wFhW8R7q5VL70h1uOu+ncxFWaxtKFHYhIQmM
 +YtI/7+J2yAA7LitvSvpJ+vAu6iE9+vDPkIu6eMTKB6J/e7Raa/7taskrzNUKXnaYXrLIcdq3
 BLbYMwOqv5YlD+Uuu+wBO9x37aG0cZu4UfrUBHOwxQi6+LKvSEzG5DerNz8jgtwpGLVghJQZS
 7u/w17EJQVFQPpy11PEAsH3a1XEG8Db01BImVNpl77uQB9Q2VQueXh5+g3zG/2GgGwzAfLP2l
 RwV0aVSW9Psf9ZviEZueFXKH6Pha36uW/Gt3OY3rAb1XGYH/kyF9eaMWwZoznwODtS7S/MaPr
 a9+IwJ8XEmw6FbLZoc98dAzh3MxSQXBGymWPLS3VS+jwugzvp7t9V5/tpa0Mgw9galo60mJ/G
 rliJiC2DTfH0kicb9GGNCbOr23cd0gZwMnYSpWnkwf6ebULkd4rUvYc2g0gvJkOq8OMEaIl4B
 1qqMRqg2LJJp22iCcqiEZas0Lf3Q+EnBGD7s43n+cSysJq8D+lFJUoRJTT++LbRnMhJTvM/3b
 mj7g/Tt8Ta6QjBjSvcbggEQwXL138LuayyHjiNm4WBG2rXy53fpQawPGV9BX0kiJ2VosUd8Ib
 WgemnZHsDxEj96RDuSuH28Sj+6wZHVvfKO2WVZBS5ern//+yO+l8nt9OVrWYw66H4zJ2kke1e
 ONkFlKpFOM4Bnqc/Fj7qb4HwXJ4umwmstQUBl4BRP3+rmVaGfz7UhSupxPwBePtq84Zz4WFE+
 /fzCBWQaqmjlZh72VyLXLVhQItpcJPXLq+RJNq6Vq+RM2xXWj9MOx2pqgL7Q=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> in_dev_get may return a NULL object.

I would prefer a wording like =E2=80=9CA null pointer can be returned by i=
n_dev_get().=E2=80=9D.


> The fix handles the situation
> by adding a check to avoid NULL pointer dereference on idev,
> as pick_local_ipaddrs does.

How do you think about the wording suggestion =E2=80=9CThus add a correspo=
nding check
so that a null pointer dereference will be avoided at this place.=E2=80=9D=
?

Please add also the tag =E2=80=9CFixes=E2=80=9D to your change description=
.

Regards,
Markus
