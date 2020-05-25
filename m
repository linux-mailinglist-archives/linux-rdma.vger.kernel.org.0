Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFE1E0ECA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbgEYMzB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 08:55:01 -0400
Received: from mout.web.de ([212.227.15.14]:43775 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390571AbgEYMzA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 08:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590411288;
        bh=M9yBPW4J5kHHK9/CQq3Pu5sFNGWYQGDAVq4xUV+feQ0=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=gsRm+oXuRX66bcmF28vx6qZx0b1HOpfh5Xu/cK4FrwnmfBeyZyrfsg3UxOQqDsiF5
         goX5R0wUyoz8Rtchme9YWld+HwL2g2EKhND4DQhmkkC9AmHO0B9m5R4q75pTpbpBNb
         osrZb8sV7Acr5ZMfCOqX+ZWUUdwkgPkZakG63Jbs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.186.124]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lw1CH-1iy5fZ2vLJ-017ltv; Mon, 25
 May 2020 14:54:48 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kangjie Lu <kjlu@umn.edu>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/core: Complete exception handling in add_port()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
To:     Qiushi Wu <wu000273@umn.edu>, linux-rdma@vger.kernel.org
Message-ID: <4bf45476-ad99-042b-d0ea-3c97bb429a98@web.de>
Date:   Mon, 25 May 2020 14:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XWEJDnQQEdU1pBpaXAjtd6ZJ0lRQJVLklhjEPa1gLLduDI/O3vy
 nerCDUxTzQ3bFaqr//ONJTM67Syp3TuXHEmCaGoNtW+NW2oWois5BhMTKNzWTn+WkjXHaNG
 0SBt0eeq+WI+/Qp6CB3TNIJL7VNlkaIh4SvkkGQaMnXDNMSO0fHf+LOPOdT2lb+AFPjoOBF
 78f1/fBvHRd7Tftf5OVRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IBw59SqexQY=:ITZZK87Pp5qt50xOA2xZPU
 2VpWE0mYYAOiE5vr4HjKKypO4z8B/zJDG1SI/uLd5cz2ZO4+UrOOhX2KO/hZpO12uTKU8Sy1z
 G2tALNANVaQU5jh4I5LjDTybTKYxcuGPDRuPfzzgPooUVkHs8pHP2nxUsDnFruWjcHUerm9Kt
 Z0voqZsKuydSVqd2hGPbRIjkdNoHguVOFqlt2Ud9embHnuMBOX9OizvNpj3l36+ExabVzs/Rq
 s6S7Te2kzFsgORvtP+UG1HykKHz4vV5KToTfXq1/b1OtZ+3qzXgf6jVpr9xgCjWUkbMjjfUXq
 ZRCb/sWXA/C4DZK9kw+Hie0w8psH5K4eFh3MlOmp5J5bSqYH2TC4HKRnTtTEaOMeC7bLnah6r
 5WARqSUaTGa0RXkv7RpKqEO4mFuq5k5jlXvlkrBP1TVtZgvE2nVs0vqBX0G+r3VRHBe9jvJ/W
 3iEvqWyk2dBro3i4yLgluWya/hnKVTrc3Sne+uM9ecWrL7MkPiRaGPt9Ajn1U6IG9MtckQivc
 /Gmxj8vKqFlixnpK0CzFMQtbvVMuc6u3IHDpTBgJMt22vTnVgoK3Pc/AFp2dC3mAhLIu2WaBk
 dGkJawjGz1nAugPunG7Hy/glFEd+/0PSDi+V3USSSr0yrI29oyA8l8D5Xb8wnMjH42RBbaII1
 CC2pabXi9LHIJox4VKFtc+9f0P1O/YdMr8ncgAK08oQAcxZ/JRDaDM0EH3ung+dc8yh4wdAgi
 hLNKRaOT3QenMSY8NRwiPwMGzq8uRnbtldPP7cm/47UMkVso8OXq9rv1ivqC98hEw+JJXalOM
 dXWRZ0oyhcpqU5uv7n4MOn9pv6JApc9kuUD4tRQ+p24LMhAoJIYuRvfw0+izPrHof4im6FqF7
 l+KkTN1mtC0kxBZ/I1Jql+3V7BH5WQRXIdmg6EO8FuBSdhT39/m6uLUxKzMOdmLuqq725CCRt
 OMmJVtIU2wZsppkgdoKkl6c919PladdzxDl+nLEWVqtRISCjK5Vk6eAQ5mkr/7Seq4z5UbC+c
 DcopNAEbmzUz37K9KgRZGYeSASzNpN6kKr2nJtrNN0inztrpjwtgwy5IkHIbaY5w/DvnSYs4+
 90iKhpCDJwmsmeOXp00+YtSaXI8bYt3a4d7m/GKn+3M1ClsIq7zq8U2G+l5Jl/Rg8FScvGq4F
 sSU25U6pQF95iIsNPl+tWudvfiixsUX2+2VV6qyCVNBy+XWk4SNKH2dO5fPQKPqYvVRWCuarw
 WfWsFre8DW2iG0+Y/
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> In function add_port(), pointer p is not released in error paths.

1. I would prefer to describe that an ib_port data structure was not relea=
sed
   in some error cases.
   How relevant can its size be here?


> Fix this issue by adding a kfree(p) into the end of error path.

2. I suggest to improve also this change description.

3. I find an other subject more appropriate.


=E2=80=A6
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1202,6 +1202,7 @@  static int add_port(struct ib_core_device *corede=
v, int port_num)
>
>  err_put:
>  	kobject_put(&p->kobj);
> +	kfree(p);
>  	return ret;
>  }

4. I recommend to add also the label =E2=80=9Cfree_port=E2=80=9D before th=
e missed function call.

   Another source code place should be accordingly adjusted then.

 	ret =3D kobject_init_and_add(&p->kobj, &port_type,
 				   coredev->ports_kobj,
 				   "%d", port_num);
-	if (ret) {
-		kfree(p);
-		return ret;
-	}
+	if (ret)
+		goto free_port;


5. Will a similar adjustment be needed for the data structure member =E2=
=80=9Cgid_attr_group=E2=80=9D
   according to the desired complete exception handling?

Regards,
Markus
